output "policy_assignments" {
  value       = azurerm_management_group_policy_assignment.policy_assignment[*]
  description = "The Policy Assignments for a Management Group"
}