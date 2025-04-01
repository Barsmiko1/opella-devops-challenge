
# opella dev Web VM Outputs
output "web_vm_id" {
  description = "ID of the web virtual machine"
  value       = azurerm_linux_virtual_machine.web_vm.id
}

output "web_vm_name" {
  description = "Name of the web virtual machine"
  value       = azurerm_linux_virtual_machine.web_vm.name
}

output "web_vm_private_ip" {
  description = "Private IP address of the web virtual machine"
  value       = azurerm_network_interface.web_vm_nic.private_ip_address
}

output "web_vm_public_ip" {
  description = "Public IP address of the web virtual machine (if created)"
  value       = var.web_vm_public_ip ? azurerm_public_ip.web_vm_public_ip[0].ip_address : null
}

# opella dev App VM Outputs
output "app_vm_id" {
  description = "ID of the app virtual machine"
  value       = azurerm_linux_virtual_machine.app_vm.id
}

output "app_vm_name" {
  description = "Name of the app virtual machine"
  value       = azurerm_linux_virtual_machine.app_vm.name
}

output "app_vm_private_ip" {
  description = "Private IP address of the app virtual machine"
  value       = azurerm_network_interface.app_vm_nic.private_ip_address
}

output "app_vm_public_ip" {
  description = "Public IP address of the app virtual machine (if created)"
  value       = var.app_vm_public_ip ? azurerm_public_ip.app_vm_public_ip[0].ip_address : null
}