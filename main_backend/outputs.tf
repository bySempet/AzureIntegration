output "vm_public_ip" {
  value = module.vm.public_ip
}

output "ssh_command" {
  value = "ssh ${module.vm.admin_username}@${module.vm.public_ip}"
}

output "key_vault_name" {
  value = azurerm_key_vault.kv.name
}

output "key_vault_secret_name" {
  value = azurerm_key_vault_secret.vm_secret.name
}
