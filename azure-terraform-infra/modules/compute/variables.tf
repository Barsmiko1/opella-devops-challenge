
variable "resource_group_name" {
  description = "Name of the resource group for the VMs"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

# opella dev Web VM Variables
variable "web_vm_name" {
  description = "Name of the web virtual machine"
  type        = string
  default     = "web-vm"
}

variable "web_subnet_id" {
  description = "ID of the web subnet where the VM will be deployed"
  type        = string
}

variable "web_vm_size" {
  description = "Size of the web VM"
  type        = string
  default     = "Standard_B2s"
}

variable "web_admin_username" {
  description = "Admin username for the web VM"
  type        = string
  default     = "adminuser"
}

variable "web_admin_ssh_key" {
  description = "SSH public key for the web VM"
  type        = string
}

variable "web_vm_public_ip" {
  description = "Whether to create a public IP for the web VM"
  type        = bool
  default     = true
}

# opella dev App VM Variables
variable "app_vm_name" {
  description = "Name of the app virtual machine"
  type        = string
  default     = "opella-dev-app-vm"
}

variable "app_subnet_id" {
  description = "ID of the app subnet where the VM will be deployed"
  type        = string
}

variable "app_vm_size" {
  description = "Size of the app VM"
  type        = string
  default     = "Standard_B2s"
}

variable "app_admin_username" {
  description = "Admin username for the app VM"
  type        = string
  default     = "adminuser"
}

variable "app_admin_ssh_key" {
  description = "SSH public key for the app VM"
  type        = string
}

variable "app_vm_public_ip" {
  description = "Whether to create a public IP for the app VM"
  type        = bool
  default     = false
}

# Common Variables
variable "os_image" {
  description = "OS image details"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "boot_diagnostics_storage_account" {
  description = "Enable boot diagnostics with this storage account"
  type        = string
  default     = ""
}