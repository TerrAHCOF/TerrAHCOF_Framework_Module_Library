variable "resource_groups" {
  type        = map(any)
  description = "(Required) A list of Azure Resource Groups with locations and tags"
}

variable "storage_account_name" {
  type        = string
  description = "Storage account for the storage container(s) to be added for this Resource Group"
}
