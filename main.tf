terraform {
    required_providers{
        azurerm = {
            version = "~> 5.0"
            source = "hashicorp/azurerm"
        }
    }
    required_version = ">= 1.10"
}

locals {
    location = "West Europe"
    tags = {
        project    = "azure-lab"
        purpose    = "terraform-state"
        managed_by = "terraform"
    }
}

provider "azurerm" {
    resource_providers_to_register = ["Microsoft.Storage"]
    features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-tfstate"
  location = local.location
  tags = local.tags
}

resource "azurerm_storage_account" "sa"  {
    name = "firststorageaccount"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    tags = local.tags
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "private"
  tags = local.tags
}


output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}

output "container_name" {
  value = azurerm_storage_container.tfstate.name
}