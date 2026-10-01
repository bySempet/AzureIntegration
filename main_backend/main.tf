locals {
  name_prefix = "azurelab-${var.environment}"
  tags = {
    project     = "azure-lab"
    environment = var.environment
    managed_by  = "terraform"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.name_prefix}"
  location = var.location
  tags     = local.tags
}

module "network" {
  source = "../modules/network"

  name_prefix         = local.name_prefix
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allowed_ssh_cidr    = var.allowed_ssh_cidr
  tags                = local.tags
}

module "vm" {
  source = "../modules/vm"

  name_prefix         = local.name_prefix
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  subnet_id           = module.network.subnet_id
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  ssh_public_key      = file(pathexpand(var.ssh_public_key_path))
  shutdown_time       = var.shutdown_time
  tags                = local.tags
}
