output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "Name of the Virtual Network"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_address_space" {
  description = "Address space of the Virtual Network"
  value       = azurerm_virtual_network.vnet.address_space
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.vnet_rg.name
}

output "resource_group_id" {
  description = "ID of the resource group"
  value       = azurerm_resource_group.vnet_rg.id
}

output "resource_group_location" {
  description = "Location of the resource group"
  value       = azurerm_resource_group.vnet_rg.location
}

output "subnet_ids" {
  description = "Map of subnet names to IDs"
  value       = { for name, subnet in azurerm_subnet.subnets : name => subnet.id }
}

output "subnet_address_prefixes" {
  description = "Map of subnet names to address prefixes"
  value       = { for name, subnet in azurerm_subnet.subnets : name => subnet.address_prefixes[0] }
}

output "nsg_ids" {
  description = "Map of NSG names to IDs"
  value       = { for name, nsg in azurerm_network_security_group.nsg : name => nsg.id }
}