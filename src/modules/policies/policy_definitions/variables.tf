variable "policy_files_directory_path" {
  type        = string
  description = "Directory path for all of the policy json files"
  default     = "policy_files"
}

variable "policy_definition_scope_id" {
  type        = string
  description = "The Management Group ID that the policies are defined under."
}
