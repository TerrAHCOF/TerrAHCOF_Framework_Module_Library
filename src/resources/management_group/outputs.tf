output "level_1_management_group_id" {
  value       = azurerm_management_group.level_1[*]
  description = "The ID of the Level 1 Management Group"
}

output "level_2_management_group_ids" {
  value       = azurerm_management_group.level_2[*]
  description = "The ID's of the Level 2 Management Groups"
}

output "level_3_management_group_ids" {
  value       = azurerm_management_group.level_3[*]
  description = "The ID's of the Level 3 Management Groups"
}

output "level_4_management_group_ids" {
  value       = azurerm_management_group.level_4[*]
  description = "The ID's of the Level 4 Management Groups"
}

output "available_subscriptions" {
  value = data.azurerm_subscriptions.available.subscriptions
}
