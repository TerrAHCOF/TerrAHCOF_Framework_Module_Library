locals {
  empty_list    = []
  empty_map     = tomap({})
  provider_path = {
    management_groups    = "/providers/Microsoft.Management/managementGroups/"
  }

  policy_definitions = {
    for value in fileset("${abspath(path.module)}/${var.policy_files_directory_path}","*.json") :
    value => jsondecode(file("${abspath(path.module)}/${var.policy_files_directory_path}/${value}"))
  }
}

resource "azurerm_policy_definition" "policy_definitions" {
  for_each               = local.policy_definitions
  name                   = each.value.name
  policy_type            = "Custom"
  mode                   = each.value.mode
  display_name           = each.value.display_name
  description            = try(each.value.description, "${each.value.name} Policy Definition at scope ${each.value.management_group_id}")
  management_group_id    = "${local.provider_path.management_groups}${each.value.management_group_id}"
  policy_rule            = try(length(each.value.policyRule) > 0, false) ? jsonencode(each.value.policyRule) : null
  metadata               = try(length(each.value.metadata) > 0, false) ? jsonencode(each.value.metadata) : null
  parameters             = try(length(each.value.parameters) > 0, false) ? jsonencode(each.value.parameters) : null
}