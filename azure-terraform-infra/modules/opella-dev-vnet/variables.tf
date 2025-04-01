
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
    name             = string
    address_prefix   = string
    service_endpoints = optional(list(string), [])
    create_nsg       = optional(bool, true)
    nsg_rules        = optional(map(object({
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