variable "policy_files_directory_path" {
  type        = string
  description = "Directory path for all of the policy json files."
  default     = "policy_files"
}

variable "policy_definition_scope_id" {
  type        = string
  description = "The Management Group ID that the policies are defined under."
}

variable "mandatory_tag_names" {
  type        = list(string)
  description = "List of mandatory tag names used by tagging policies"
}

variable "mandatory_tags_with_value_rules" {
  type = list(string)
  description = "List of mandatory tags used that require value rules (e.g. not allowed values)"
}

variable "tag_values_not_allowed" {
  type = list(string)
  description = "list of tag values that are not allowed"
  default = [
        "",
        "NA",
        "N/A",
        "tbc",
        "'tbc'",
        "TBC",
        "to_be_confirmed",
        "to be confirmed"
      ]
}
