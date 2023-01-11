output "level_1_management_group_id" {
  value       = module.management_group.level_1_management_group_id
  description = "The ID of the Level 1 Management Group"
}

output "level_2_management_group_ids" {
  value       = module.management_group.level_2_management_group_ids
  description = "The ID's of the Level 2 Management Group"
}

output "level_3_management_group_ids" {
  value       = module.management_group.level_3_management_group_ids
  description = "The ID's of the Level 3 Management Group"
}

output "level_4_management_group_ids" {
  value       = module.management_group.level_4_management_group_ids
  description = "The ID's of the Level 4 Management Group"
}
