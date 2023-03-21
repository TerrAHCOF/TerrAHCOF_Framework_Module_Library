output "requireTagsOnRG_policy_definition" {
  value       = module.tagging_policy_definitions.requireTagsOnRG_policy_definition
  description = "The policy definition for requireTagsOnRG"
}

output "inheritTagsFromRG_policy_definition" {
  value       = module.tagging_policy_definitions.inheritTagsFromRG_policy_definition
  description = "The policy definition defined for inheritTagsFromRG"
}

output "inheritTagValuesFromRG_policy_definition" {
  value       = module.tagging_policy_definitions.inheritTagValuesFromRG_policy_definition
  description = "The policy definition defined for inheritTagValuesFromRG"
}

output "tagsWithValueRules_policy_definition" {
  value       = module.tagging_policy_definitions.tagsWithValueRules_policy_definition
  description = "The policy definition defined for tagsWithValueRules"
}
