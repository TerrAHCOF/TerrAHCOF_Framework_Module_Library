module "policy_definitions" {
  source                      = "../../../resources/policies/policy_definitions"
  policy_files_directory_path = var.policy_files_directory_path
  policy_definition_scope_id  = var.policy_definition_scope_id
}
