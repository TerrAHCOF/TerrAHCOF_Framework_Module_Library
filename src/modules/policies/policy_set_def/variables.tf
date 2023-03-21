variable "policy_set_definitions_files_directory_path" {
  type        = string
  description = "Directory path for all of the policy set definition json files"
  default     = "policy_set_files"
}

variable "policy_set_definition_scope_id" {
  type        = string
  description = "The Management Group ID that the policy sets are defined under."
}
