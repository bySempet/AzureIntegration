terraform {
  backend "azurerm" {
    use_azuread_auth = true
    key              = "dev.terraform.tfstate"
  }
  required_providers {
    azurerm = {
      version = "~> 5.0"
      source  = "hashicorp/azurerm"
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

provider "azurerm" {
  resource_providers_to_register = [
    "Microsoft.Compute",
    "Microsoft.Network",
    "Microsoft.DevTestLab",
    "Microsoft.KeyVault"
  ]
  features {}
}
