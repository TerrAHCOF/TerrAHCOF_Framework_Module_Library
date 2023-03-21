output "state_file_storage_accounts" {
  value       = azurerm_storage_account.state_file_storage_accounts
  description = "The Storage Accounts created to store state files"
}
