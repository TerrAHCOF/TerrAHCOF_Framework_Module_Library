provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terrahcof-state-ae"
    storage_account_name = "stterrahcofstateae"
    container_name       = "tfstate"
    key                  = "terrAHCOFvalidation.tfstate"
  }
}
