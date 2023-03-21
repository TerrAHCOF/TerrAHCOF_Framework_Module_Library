output "requireTagsOnRG_policy_definition" {
  value       = azurerm_policy_definition.requireTagsOnRG
  description = "The policy definition for requireTagsOnRG"
}

output "inheritTagsFromRG_policy_definition" {
  value       = azurerm_policy_definition.inheritTagsFromRG
  description = "The policy definition defined for inheritTagsFromRG"
}

output "inheritTagValuesFromRG_policy_definition" {
  value       = azurerm_policy_definition.inheritTagValuesFromRG
  description = "The policy definition defined for inheritTagValuesFromRG"
}

output "tagsWithValueRules_policy_definition" {
  value       = azurerm_policy_definition.tagsWithValueRules
  description = "The policy definition defined for tagsWithValueRules"
}

