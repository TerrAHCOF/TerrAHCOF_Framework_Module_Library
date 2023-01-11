output "resource_groups" {
  value       = azurerm_resource_group.resource_groups[*]
  description = "The resource groups created by module"
}