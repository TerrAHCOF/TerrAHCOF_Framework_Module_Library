variable "state_file_storage_accounts" {
  type        = map(any)
  description = "All the storage accounts to be created."
}

variable "business_function" {
  type        = string
  description = "Top level business function"
}

variable "location" {
  type        = string
  description = "The Azure region where the resource is deployed."
}

variable "location_short_name" {
  type        = string
  description = "Short name for the the Azure region where the resource is deployed."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account. Changing this forces a new resource to be created."
}


