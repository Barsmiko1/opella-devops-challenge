subscription_id     = "9ee4732b-43be-4a49-9c51-098d964fb788"
resource_group_name = "rg-opella-dev"
location            = "eastus"
vnet_name           = "opella-dev-vnet"
address_space       = ["10.5.0.0/16"]
dns_servers         = []

# Definining developement env subnets
subnets = [
  {
    name              = "web-subnet"
    address_prefix    = "10.5.0.0/24"
    service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
    nsg_rules = {
      allow_http = {
        priority               = 100
        destination_port_range = "80"
      },
      allow_https = {
        priority               = 101
        destination_port_range = "443"
      },
      allow_ssh = {
        priority               = 102
        destination_port_range = "22"
      }
    }
  },
  {
    name              = "app-subnet"
    address_prefix    = "10.5.1.0/24"
    service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
    nsg_rules = {
      allow_http = {
        priority               = 100
        destination_port_range = "8080"
      }
    }
  }
]

# tags
tags = {
  Environment = "Development"
  Project     = "Opella DevOps Challenge"
  CostCenter  = "DEV-123"
}

# NAT Gateway Configuration
create_nat_gateway       = true
nat_gateway_subnet_names = ["web-subnet", "app-subnet"]

# Opella VM Configuration
admin_username = "opellaadmin"
admin_ssh_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzep1DcBJZTVfOv9zX+fdbl2DreMQGA8TBxyhSYToxj4Xd2b7fkxeYX2qXcZ+PBXTiEWltmpBGN/wOmkPxUf5iLRUauFtpHlxuBU9eLKKK3DMaDwmyzbWXUKP6DenFet2wgfnC5VRrHnZeTnrcoJyGI5UWtLiQESZ1eqOSH2uGRkhpCek/8yr1iHQfs5A4NPqGztGmgXgy2UagUMRTzQRiBQzAl43zOZdhh/UtQBgS3dhMlUC3DGfISX5x3p9pfYxWhWm8htBTvuRj8X4BWg1Sb4Jxp1img4Rhpwp29D3VjUn6VH3xlFnJUBeDTmiG4fmTtt4T+dWllhoNY7i0bVvT michael-mac-pro"

# Opella Web VM Configuration
web_vm_name          = "opella-web-vm"
web_vm_size          = "Standard_B2s"
web_vm_public_ip     = true

# Opella App VM Configuration
app_vm_name          = "opella-app-vm"
app_vm_size          = "Standard_B2s"
app_vm_public_ip     = false

# OS Image Configuration
os_image = {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-jammy"
  sku       = "22_04-lts-gen2"
  version   = "latest"
}

# Storage Account for Boot Diagnostics
boot_diagnostics_storage_account = ""