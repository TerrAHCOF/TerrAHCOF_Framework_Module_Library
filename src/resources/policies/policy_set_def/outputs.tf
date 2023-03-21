output "policy_set_definitions" {
  value       = azurerm_policy_set_definition.policy_set_definitions[*]
  description = "The Policy Set Definitions"
}