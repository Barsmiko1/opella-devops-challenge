
# Create public IP for the dev app VM when enabled
resource "azurerm_public_ip" "app_vm_public_ip" {
  count               = var.app_vm_public_ip ? 1 : 0
  
  name                = "${var.app_vm_name}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = merge(local.service_tags, var.tags)
}

# Create Network Interface for dev app VM
resource "azurerm_network_interface" "app_vm_nic" {
  name                = "${var.app_vm_name}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location
  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.app_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.app_vm_public_ip ? azurerm_public_ip.app_vm_public_ip[0].id : null
  }
  
  tags = merge(local.service_tags, var.tags)
}

# Create the dev app VM
resource "azurerm_linux_virtual_machine" "app_vm" {
  name                = var.app_vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.app_vm_size
  admin_username      = var.app_admin_username
  
  network_interface_ids = [
    azurerm_network_interface.app_vm_nic.id,
  ]

  admin_ssh_key {
    username   = var.app_admin_username
    public_key = var.app_admin_ssh_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = var.os_image.publisher
    offer     = var.os_image.offer
    sku       = var.os_image.sku
    version   = var.os_image.version
  }

  # Enable boot diagnostics if storage account provided
  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics_storage_account != "" ? [1] : []
    content {
      storage_account_uri = "https://${var.boot_diagnostics_storage_account}.blob.core.windows.net/"
    }
  }

  tags = merge(local.common_tags, var.tags)
}