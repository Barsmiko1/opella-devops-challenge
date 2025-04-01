
# Variables for opella dev vnet Module
variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group for the VNET"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "address_space" {
  description = "Address space for the VNET"
  type        = list(string)
  default     = ["10.5.0.0/16"]
}

variable "dns_servers" {
  description = "DNS servers for the VNET"
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "Map of subnet objects with their configuration"
  type = list(object({
    name              = string
    address_prefix    = string
    service_endpoints = optional(list(string), [])
    create_nsg        = optional(bool, true)
    nsg_rules = optional(map(object({
      priority                   = number
      direction                  = optional(string, "Inbound")
      access                     = optional(string, "Allow")
      protocol                   = optional(string, "Tcp")
      source_port_range          = optional(string, "*")
      destination_port_range     = optional(string, "*")
      source_address_prefix      = optional(string, "*")
      destination_address_prefix = optional(string, "*")
    })), {})
    delegation = optional(object({
      name                       = string
      service_delegation_name    = string
      service_delegation_actions = optional(list(string), [])
    }), null)
  }))
  default = []
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "create_nat_gateway" {
  description = "Whether to create a NAT Gateway for outbound internet connectivity"
  type        = bool
  default     = false
}

variable "nat_gateway_subnet_names" {
  description = "List of subnet names to associate with the NAT Gateway"
  type        = list(string)
  default     = []
}

# Variables for dev compute Module

variable "admin_username" {
  description = "Admin username for VMs"
  type        = string
  default     = "adminuser"
}

variable "admin_ssh_key" {
  description = "SSH public key for VM access"
  type        = string
}

variable "web_vm_name" {
  description = "Name of the web VM"
  type        = string
  default     = "opella-web-vm"
}

variable "web_vm_size" {
  description = "Size of the web VM"
  type        = string
  default     = "Standard_B2s"
}

variable "web_vm_public_ip" {
  description = "Whether to create a public IP for web VM"
  type        = bool
  default     = true
}

variable "app_vm_name" {
  description = "Name of the app VM"
  type        = string
  default     = "opella-app-vm"
}

variable "app_vm_size" {
  description = "Size of the app VM"
  type        = string
  default     = "Standard_B2s"
}

variable "app_vm_public_ip" {
  description = "Whether to create a public IP for app VM"
  type        = bool
  default     = false
}

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

variable "boot_diagnostics_storage_account" {
  description = "Storage account name for boot diagnostics"
  type        = string
  default     = ""
}