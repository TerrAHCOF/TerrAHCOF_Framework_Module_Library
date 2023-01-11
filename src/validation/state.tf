provider "azurerm" {
  subscription_id = ""
  tenant_id       = ""
  features {}
}

terraform {
  backend "azurerm" {
  }
}
