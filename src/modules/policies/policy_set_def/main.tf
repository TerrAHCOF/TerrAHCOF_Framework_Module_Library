module "policy_set_def" {
  source                                      = "../../../resources/policies/policy_set_def"
  policy_set_definitions_files_directory_path = var.policy_set_definitions_files_directory_path
  policy_set_definition_scope_id              = var.policy_set_definition_scope_id
}
