############################################################################
############################################################################
## This file is created and maintained by DevOps Engineering team 
############################################################################
############################################################################
## Define local varialbes for the management group and policy
locals {
  empty_list   = []
  empty_map    = tomap({})
  provider_path = {
    management_groups      = "/providers/Microsoft.Management/managementGroups/"
    policy_set_definitions = "/providers/Microsoft.Authorization/policySetDefinitions/"
  }
}

## assign policy set based on the variables defined in variables.tf
resource "azurerm_management_group_policy_assignment" "policy_assignment" {
  for_each             = var.policy_assignments
  name                 = tonumber(length(each.key) > 24 ? "The policy assignment name '${each.key}' is invalid. The policy assignment name length must not exceed '24' characters." : length(each.key)) > 24 ? null : each.key
  management_group_id  = "${local.provider_path.management_groups}${each.value.management_group_id}"
  policy_definition_id = "${each.value.policy_definition_id}"
  location             = try(each.value.location, null)
  description          = try(each.value.description, "${each.key} Policy Assignment at scope ${each.value.management_group_id}")
  display_name         = try(each.value.displayName, each.key)
  metadata             = try(length(each.value.metadata) > 0, false) ? jsonencode(each.value.metadata) : null
  parameters           = try(length(each.value.parameters) > 0, false) ? jsonencode(each.value.parameters) : null
  not_scopes           = try(each.value.notScopes, local.empty_list)
  enforce              = each.value.enforcement_mode

  dynamic "identity" {
    for_each = {
      for ik, iv in try(each.value.identity, local.empty_map) :
      ik => iv
      if lower(iv) == "systemassigned"
    }
    content {
      type = "SystemAssigned"
    }
  }
}