## Define local variables for the storage accounts
locals {

  ## loop through the state_file_storage_accounts variable to pass through the defined value in the variable.tf file. 
  state_file_storage_accounts_map = {
    for key, value in var.state_file_storage_accounts :
    "${key}" => {
      business_unit = value.business_unit
      environment   = value.environment
    }
  }
}

## Main resource block for the module creates all stroage accounts in local map variable uses standardised namming convention to contstruct name.
resource "azurerm_storage_account" "state_file_storage_accounts" {
  for_each                 = local.state_file_storage_accounts_map
  name                     = lower("st${var.business_function}${each.value.business_unit}${var.location_short_name}${each.value.environment}")
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  min_tls_version          = "TLS1_2"

  lifecycle {
    ignore_changes = [tags]
  }
}
