terraform {
    required_providers{
        azurerm = {
            version = "~> 5.0"
            source = "hashicorp/azurerm"
        }
        random = {
          source  = "hashicorp/random"
          version = "~> 3.9"
        }
        time = {
          source  = "hashicorp/time"
          version = "~> 0.13"
        }

      }
    required_version = ">= 1.10"
}

locals {
    location = "North Europe"
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
resource "random_string" "suffix" {
  length  = 6
  special = false 
  upper   = false 
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-tfstate"
  location = local.location
  tags = local.tags
}

resource "azurerm_storage_account" "sa"  {
    name = "sttfstate${random_string.suffix.result}"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    tags = local.tags
}

resource "time_sleep" "wait_for_storage_account" {
  depends_on      = [azurerm_storage_account.sa]
  create_duration = "90s"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "private"
  depends_on = [time_sleep.wait_for_storage_account]
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