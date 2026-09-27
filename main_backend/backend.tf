terraform {
  backend "azurerm" {
    use_azuread_auth     = true
    key                  = "dev.terraform.tfstate"
  }
  required_providers {
    azurerm = {
        version = "~> 5.0"
        source  = "hashicorp/azurerm"
    }
  }
}
