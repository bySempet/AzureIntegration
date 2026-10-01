output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
  value      = azurerm_subnet.subnet.id
  depends_on = [azurerm_subnet_network_security_group_association.subnet_nsg]
}

output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}
