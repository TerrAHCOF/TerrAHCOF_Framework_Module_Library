
output "state_file_storage_accounts" {
  value       = module.state_file_management.state_file_storage_accounts
  description = "The storage accounts created to store state files."
}
