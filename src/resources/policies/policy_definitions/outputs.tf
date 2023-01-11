output "policy_definitions" {
  value       = azurerm_policy_definition.policy_definitions[*]
  description = "The policy definitions defined from policy json files"
}