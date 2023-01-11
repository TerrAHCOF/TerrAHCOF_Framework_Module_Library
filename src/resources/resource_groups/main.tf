data "azurerm_subscription" "primary" {
}

data "azuread_groups" "all" {
  return_all = true
}

data "azuread_users" "all" {
  return_all = true
}

data "azuread_service_principals" "all" {
  return_all = true
}

data "azuread_group" "current_groups" {
  for_each  = local.groups_to_map
  object_id = each.value
}

data "azuread_user" "current_users" {
  for_each  = local.users_map
  object_id = each.value.object_id
}

data "azuread_service_principal" "current_service_principals" {
  for_each  = local.service_principals_map
  object_id = each.value[0].object_id
}

locals {
  provider_path = {
    role_definition = "${data.azurerm_subscription.primary.id}/providers/Microsoft.Authorization/roleDefinitions/"
  }

  groups_to_map = zipmap(data.azuread_groups.all.display_names.*, data.azuread_groups.all.object_ids.*)

  users_map = {
    for obj in data.azuread_users.all.users.* : obj.display_name => obj
  }

  service_principals_map = {
    for obj in data.azuread_service_principals.all.service_principals.* : obj.display_name => obj...
  }


  role_assignments_mapping = flatten([
    for rg-key, rg-value in var.resource_groups : [
      for permission-key, value in rg-value.permissions : {
        rg-key               = rg-key
        permission-key       = permission-key
        principal_id         = try(try(try(data.azuread_group.current_groups[value.group_or_user_display_name].object_id, data.azuread_user.current_users[value.group_or_user_display_name].object_id), data.azuread_service_principal.current_service_principals[value.group_or_user_display_name].object_id), null)
        role_definition_name = value.role_definition_name
      }
    ]
  ])

  role_assignments = {
    for key, value in local.role_assignments_mapping :
    key => value
    if value.principal_id != null
  }
}

resource "azurerm_resource_group" "resource_groups" {
  for_each = var.resource_groups
  name     = each.key
  location = each.value.location
  tags     = each.value.tags
}

resource "azurerm_role_assignment" "assign_role_to_resource_group" {
  for_each             = { for role_assignment in local.role_assignments : "${role_assignment.rg-key}-${role_assignment.permission-key}" => role_assignment }
  scope                = azurerm_resource_group.resource_groups[each.value.rg-key].id
  principal_id         = each.value.principal_id
  role_definition_name = each.value.role_definition_name
  depends_on           = [azurerm_resource_group.resource_groups]
}

