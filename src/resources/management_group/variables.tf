variable "root_id" {
  type        = string
  description = "This is the root level ID which is equivalent to level 1 of the mg and it is the root level."
}

variable "root_parent_id" {
  type        = string
  description = "This is the tenancy MG root ID."
}

variable "management_groups" {
  type        = map(any)
  description = "List of management group in map structure for all MG groups."
}

variable "canary_required" {
  type        = bool
  description = "Boolean value to toggle the canary environment."
}
