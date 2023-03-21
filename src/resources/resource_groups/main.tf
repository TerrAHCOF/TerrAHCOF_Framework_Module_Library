############################################################################
############################################################################
##  Name: Resource Groups Module
##  Version: 0.0.2
##  Description: This module creates resoruce groups, role assignments, storage containers for a service based on mapped input.
##  Created on 15/7/2022
##  Author: Tosh Mackevics <tosh.mackevics@mbie.govt.nz>
##  Team: Quality Engineering
##  Company: Ministry of Business Innovation and Employment
############################################################################
############################################################################

## Gets the current subscription to use for getting azuread values.
data "azurerm_subscription" "primary" {
}

## Gets all the azure groups.
data "azuread_groups" "all" {
  return_all = true
}

## Gets all the azure users.
data "azuread_users" "all" {
  return_all = true
}

## Gets all the azure service principals.
data "azuread_service_principals" "all" {
  return_all = true
}

## Used to construct the maps
data "azuread_group" "current_groups" {
  for_each  = local.groups_to_map
  object_id = each.value
}

## Used to construct the maps
data "azuread_user" "current_users" {
  for_each  = local.users_map
  object_id = each.value.object_id
}

## Used to construct the maps
data "azuread_service_principal" "current_service_principals" {
  for_each  = local.service_principals_map
  object_id = each.value[0].object_id
}

## Define local variables for the storage containers
locals {
  provider_path = {
    role_definition = "${data.azurerm_subscription.primary.id}/providers/Microsoft.Authorization/roleDefinitions/"
  }

  ## Maps group display names to their object IDs.
  groups_to_map = zipmap(data.azuread_groups.all.display_names.*, data.azuread_groups.all.object_ids.*)

  ## Maps users display names to their object IDs.
  users_map = {
    for obj in data.azuread_users.all.users.* : obj.display_name => obj
  }

  ## Maps service principal dispaly names to their object IDs.
  service_principals_map = {
    for obj in data.azuread_service_principals.all.service_principals.* : obj.display_name => obj...
  }

  ## Creates a map for the role assignments that will be linked to which resource group and storage container based on the esource_groups variable.
  role_assignments_mapping = flatten([
    for rg-key, rg-value in var.resource_groups : [
      for permission-key, value in rg-value.permissions : {
        rg-key            = rg-key
        storage_container = rg-value.tags["ServiceName"]
        permission-key    = permission-key
        principal_id = try(
          try(
            try(
              data.azuread_group.current_groups[value.group_or_user_display_name].object_id, data.azuread_user.current_users[value.group_or_user_display_name].object_id ## Determines if the display name provided is a Azure Group or Azure User.
            ),
            data.azuread_service_principal.current_service_principals[value.group_or_user_display_name].object_id ## Determines if the display name provided is a Azure Service Principal.
          ),
        null) ## Determines if display name provided will return a object id to be used as the principal id
        role_definition_name = value.role_definition_name
      }
    ]
  ])

  ## Loops through the mapped role assignment variable to determine if a role assignemnt has been specified.
  role_assignments = {
    for key, value in local.role_assignments_mapping :
    key => value
    if value.principal_id != null
  }

  ## Determines all storage containers that need to be created based on the ServiceName tag of the resource group and removes the duplicates.
  storage_container_map = distinct([
    for key, value in var.resource_groups : "${value.tags["ServiceName"]}"
  ])
}

## Resource block for creating all resource groups listed in the resource_groups variable. 
resource "azurerm_resource_group" "resource_groups" {
  for_each = var.resource_groups
  name     = each.key
  location = each.value.location
  tags     = each.value.tags
}

## Resource block for assigning role assignments to containers listed in role_assignments variable. 
resource "azurerm_role_assignment" "assign_role_to_resource_group" {
  for_each             = { for role_assignment in local.role_assignments : "${role_assignment.rg-key}-${role_assignment.permission-key}" => role_assignment }
  scope                = azurerm_resource_group.resource_groups[each.value.rg-key].id
  principal_id         = each.value.principal_id
  role_definition_name = each.value.role_definition_name
  depends_on           = [azurerm_resource_group.resource_groups]
}

## Resource block for creating all storage containers listed in the storage_container_map local variable. 
## Constructs name based on standardised naming convention.
resource "azurerm_storage_container" "storage_container" {
  for_each              = { for storage_container in local.storage_container_map : "${storage_container}" => storage_container }
  name                  = lower("${each.value}tfstate")
  storage_account_name  = var.storage_account_name
  container_access_type = "private"
}

## Resource block for assigning role assignments to containers listed in the local role_assignments variable. 
resource "azurerm_role_assignment" "assign_role_storage_container" {
  for_each             = { for role_assignment in local.role_assignments : "${role_assignment.rg-key}-${role_assignment.permission-key}" => role_assignment }
  scope                = azurerm_storage_container.storage_container[each.value.storage_container].resource_manager_id
  principal_id         = each.value.principal_id
  role_definition_name = each.value.role_definition_name
  depends_on           = [azurerm_storage_container.storage_container]
}
