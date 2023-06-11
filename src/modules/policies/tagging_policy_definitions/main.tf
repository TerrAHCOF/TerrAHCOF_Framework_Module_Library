module "tagging_policy_definitions" {
  source                          = "../../../resources/policies/tagging_policy_definitions"
  policy_files_directory_path     = var.policy_files_directory_path
  policy_definition_scope_id      = var.policy_definition_scope_id
  mandatory_tag_names             = var.mandatory_tag_names
  mandatory_tags_with_value_rules = var.mandatory_tags_with_value_rules
  tag_values_not_allowed          = var.tag_values_not_allowed
}
