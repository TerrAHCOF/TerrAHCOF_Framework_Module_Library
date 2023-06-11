module "state_file_management" {
  source                      = "../../resources/state_file_management"
  state_file_storage_accounts = var.state_file_storage_accounts
  business_function           = var.business_function
  location                    = var.location
  location_short_name         = var.location_short_name
  resource_group_name         = var.resource_group_name
}
