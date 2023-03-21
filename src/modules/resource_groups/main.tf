module "resource_groups" {
  source               = "../../resources/resource_groups"
  resource_groups      = var.resource_groups
  storage_account_name = var.storage_account_name
}
