
output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = module.opella-dev-vnet.vnet_id
}

output "vnet_name" {
  description = "Name of the Virtual Network"
  value       = module.opella-dev-vnet.vnet_name
}

output "vnet_address_space" {
  description = "Address space of the Virtual Network"
  value       = module.opella-dev-vnet.vnet_address_space
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.opella-dev-vnet.resource_group_name
}

output "resource_group_id" {
  description = "ID of the resource group"
  value       = module.opella-dev-vnet.resource_group_id
}

output "subnet_ids" {
  description = "Map of subnet names to IDs"
  value       = module.opella-dev-vnet.subnet_ids
}

output "subnet_address_prefixes" {
  description = "Map of subnet names to address prefixes"
  value       = module.opella-dev-vnet.subnet_address_prefixes
}

output "nsg_ids" {
  description = "Map of NSG names to IDs"
  value       = module.opella-dev-vnet.nsg_ids
}

# VM Outputs
output "web_vm_id" {
  description = "ID of the opella dev web virtual machine"
  value       = module.compute.web_vm_id
}

output "web_vm_private_ip" {
  description = "Private IP address of the opella dev web virtual machine"
  value       = module.compute.web_vm_private_ip
}

output "web_vm_public_ip" {
  description = "Public IP address of the opella dev web virtual machine"
  value       = module.compute.web_vm_public_ip
}

output "app_vm_id" {
  description = "ID of the opella dev app virtual machine"
  value       = module.compute.app_vm_id
}

output "app_vm_private_ip" {
  description = "Private IP address of the opella dev app virtual machine"
  value       = module.compute.app_vm_private_ip
}