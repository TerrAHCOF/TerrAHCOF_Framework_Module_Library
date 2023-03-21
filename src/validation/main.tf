############################################################################
############################################################################
# Update the section below to add the module that you want the CICD pipeline
# to run and provision AZ resources
############################################################################
############################################################################

## Create management group structure for AZ tenancy, see variables.tf file
## for information of the MG varialbes
module "management_group" {
  source            = "../modules/management_group"
  root_id           = var.root_id
  root_parent_id    = var.root_parent_id
  management_groups = var.management_groups
  canary_required   = var.canary_required
}

## Assign AZ policies to the MG scopes
module "policy_assignments" {
  source             = "../modules/policies/policy_assignments"
  policy_assignments = var.policy_assignments
  depends_on = [
    module.management_group,
    module.policy_definitions,
    module.policy_set_def
  ]
}

module "policy_definitions" {
  source                     = "../modules/policies/policy_definitions"
  policy_definition_scope_id = var.root_id
  depends_on                 = [module.management_group]
}

module "policy_set_def" {
  source                         = "../modules/policies/policy_set_def"
  policy_set_definition_scope_id = var.root_id
  depends_on = [
    module.management_group,
    module.policy_definitions
  ]
}

module "resource_groups" {
  source               = "../modules/resource_groups"
  resource_groups      = var.resource_groups
  storage_account_name = var.storage_account_name
}

module "tagging_policy_definitions" {
  source                          = "../modules/policies/tagging_policy_definitions"
  policy_definition_scope_id      = var.root_id
  mandatory_tag_names             = var.mandatory_tag_names
  mandatory_tags_with_value_rules = var.mandatory_tags_with_value_rules
}

module "state_file_management" {
  source                      = "../modules/state_file_management"
  resource_group_name         = var.state_files_resource_group
  state_file_storage_accounts = var.state_file_storage_accounts
}
