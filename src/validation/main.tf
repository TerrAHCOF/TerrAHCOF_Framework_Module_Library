############################################################################
############################################################################
# Update the section below to add the module that you want the pipeline
# to run and provision Azure resources
############################################################################
############################################################################

## Create management group structure for Azure tenancy, see variables.tf file
## for information of the Management Group variables
module "management_group" {
  source            = "../modules/management_group"
  root_id           = var.root_id
  root_parent_id    = var.root_parent_id
  management_groups = var.management_groups
  canary_required   = var.canary_required
}

## Assign Azure policies to the MG scopes
module "policy_assignments" {
  source             = "../modules/policies/policy_assignments"
  policy_assignments = var.policy_assignments
  depends_on = [
    module.management_group,
    module.policy_definitions,
    module.policy_set_definitions
  ]
}

module "policy_definitions" {
  source     = "../modules/policies/policy_definitions"
  depends_on = [module.management_group]
}

module "policy_set_definitions" {
  source = "../modules/policies/policy_set_definitions"
  depends_on = [
    module.management_group,
    module.policy_definitions
  ]
}

module "resource_groups" {
  source          = "../modules/resource_groups"
  resource_groups = var.resource_groups
}

