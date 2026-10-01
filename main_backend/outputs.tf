output "vm_public_ip" {
  value = module.vm.public_ip
}

output "ssh_command" {
  value = "ssh ${module.vm.admin_username}@${module.vm.public_ip}"
}
