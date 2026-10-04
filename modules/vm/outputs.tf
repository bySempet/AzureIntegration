output "vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "public_ip" {
  value = azurerm_public_ip.pip.ip_address
}

output "admin_username" {
  value = var.admin_username
}

output "principal_id" {
  description = "Object ID de la identidad gestionada de la VM en Entra ID"
  value       = azurerm_linux_virtual_machine.vm.identity[0].principal_id
}
