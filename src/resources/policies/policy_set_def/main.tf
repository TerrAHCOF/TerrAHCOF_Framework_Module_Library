locals {
  provider_path = {
    management_groups  = "/providers/Microsoft.Management/managementGroups/"
    policy_definitions = "/providers/Microsoft.Authorization/policyDefinitions/"
  }

  policy_set_definitions = {
    for value in fileset("${abspath(path.module)}/${var.policy_set_definitions_files_directory_path}", "**/*.json") :
    value => jsondecode(file("${abspath(path.module)}/${var.policy_set_definitions_files_directory_path}/${value}"))
  }
}


resource "azurerm_policy_set_definition" "policy_set_definitions" {
  for_each     = local.policy_set_definitions
  name         = each.value.name
  policy_type  = "Custom"
  display_name = each.value.display_name

  dynamic "policy_definition_reference" {
    for_each = [
      for item in each.value.policy_definitions :
      {
        policy_definition_id = try(item.policy_type == "Custom", false) ? "${local.provider_path.management_groups}${var.policy_set_definition_scope_id}${local.provider_path.policy_definitions}${item.policy_definition_id}" : "${local.provider_path.policy_definitions}${item.policy_definition_id}"
        parameter_values     = try(jsonencode(item.parameters), null)
        reference_id         = try(item.policy_definition_reference_id, null)
      }
    ]
    content {
      policy_definition_id = policy_definition_reference.value["policy_definition_id"]
      parameter_values     = policy_definition_reference.value["parameter_values"]
      reference_id         = policy_definition_reference.value["reference_id"]
    }
  }
  description         = try(each.value.description, "${each.value.display_bame} Policy Set Definition at scope ${var.policy_set_definition_scope_id}")
  management_group_id = try("${local.provider_path.management_groups}${var.policy_set_definition_scope_id}", null)
  metadata            = try(length(each.value.metadata) > 0, false) ? jsonencode(each.value.metadata) : null
  parameters          = try(length(each.value.parameters) > 0, false) ? jsonencode(each.value.parameters) : null
}
