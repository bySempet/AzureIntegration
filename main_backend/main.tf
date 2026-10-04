locals {
  name_prefix = "azurelab-${var.environment}"
  tags = {
    project     = "azure-lab"
    environment = var.environment
    managed_by  = "terraform"
  }
}

data "azurerm_client_config" "current" {}

resource "random_string" "suffix" {
  length  = 10
  special = false
  upper   = false
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

resource "azurerm_key_vault" "kv" {
  name                       = "kv-${random_string.suffix.result}"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  rbac_authorization_enabled = true
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  sku_name                   = "standard"
}

resource "azurerm_role_assignment" "kv_secrets_officer" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "kv_secrets_user_vm" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = module.vm.principal_id
  principal_type       = "ServicePrincipal"
}


resource "time_sleep" "wait_for_kv_rbac" {
  depends_on      = [azurerm_role_assignment.kv_secrets_officer]
  create_duration = "90s"
}

resource "random_password" "vm_secret" {
  length  = 24
  special = true
}

resource "azurerm_key_vault_secret" "vm_secret" {
  name         = "vm-secret"
  value        = random_password.vm_secret.result
  content_type = "password"
  key_vault_id = azurerm_key_vault.kv.id
  depends_on   = [time_sleep.wait_for_kv_rbac]
}
