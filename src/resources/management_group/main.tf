############################################################################
############################################################################
## 
############################################################################
############################################################################

data "azurerm_subscriptions" "available" {
}

data "azurerm_subscription" "current_subscriptions" {
  for_each        = local.subscriptions_map
  subscription_id = each.value.subscription_id
}

## Define local varialbes for the management group
locals {
  empty_string = ""
  ## default provider path for management group
  provider_path = {
    management_groups = "/providers/Microsoft.Management/managementGroups/"
  }

  subscriptions_map = {
    for obj in data.azurerm_subscriptions.available.subscriptions.* : obj.display_name => obj
  }

  ## canary variable names builder based on the existing management group
  management_group_canary = {
    for key, value in var.management_groups :
    "${local.provider_path.management_groups}canary_${key}" => {
      id                         = "canary_${key}"
      display_name               = "canary-${value.display_name}"
      parent_management_group_id = "${value.parent_management_group_id}" == var.root_id ? var.root_id : "canary_${value.parent_management_group_id}"
      subscription_ids = try([for subs in value.canary_subscription_names :
        data.azurerm_subscription.current_subscriptions["${subs}"].subscription_id
      ], null)
    }
    if var.canary_required == true
  }

  ## loop through the mg variables to pass through the defined value in the variable.tf file
  management_groups_map = {
    for key, value in var.management_groups :
    "${local.provider_path.management_groups}${key}" => {
      id                         = key
      display_name               = value.display_name
      parent_management_group_id = coalesce(value.parent_management_group_id, var.root_parent_id)
      subscription_ids = try([for subs in value.subscription_names :
        data.azurerm_subscription.current_subscriptions["${subs}"].subscription_id
      ], null)
    }
  }

  ## build the full path of the canary mg
  management_groups_merge = merge(
    local.management_groups_map,
    local.management_group_canary
  )


  ## pass level 1 variables to the resource creation script below
  azurerm_management_group_level_1 = {
    for key, value in local.management_groups_merge :
    key => value
    if value.parent_management_group_id == var.root_parent_id
  }

  ## pass level 2 variables to the resource creation script below
  azurerm_management_group_level_2 = {
    for key, value in local.management_groups_merge :
    key => value
    if contains(keys(azurerm_management_group.level_1), try(length(value.parent_management_group_id) > 0, false) ? "${local.provider_path.management_groups}${value.parent_management_group_id}" : local.empty_string)
  }

  ## pass level 3 variables to the resource creation script below
  azurerm_management_group_level_3 = {
    for key, value in local.management_groups_merge :
    key => value
    if contains(keys(azurerm_management_group.level_2), try(length(value.parent_management_group_id) > 0, false) ? "${local.provider_path.management_groups}${value.parent_management_group_id}" : local.empty_string)
  }

  azurerm_management_group_level_4 = {
    for key, value in local.management_groups_merge :
    key => value
    if contains(keys(azurerm_management_group.level_3), try(length(value.parent_management_group_id) > 0, false) ? "${local.provider_path.management_groups}${value.parent_management_group_id}" : local.empty_string)
  }
}

## create level 1 mg
resource "azurerm_management_group" "level_1" {
  for_each                   = local.azurerm_management_group_level_1
  name                       = each.value.id
  display_name               = each.value.display_name
  parent_management_group_id = "${local.provider_path.management_groups}${each.value.parent_management_group_id}"
  subscription_ids           = each.value.subscription_ids

}

## create level 2 mg
resource "azurerm_management_group" "level_2" {
  for_each                   = local.azurerm_management_group_level_2
  name                       = each.value.id
  display_name               = each.value.display_name
  parent_management_group_id = "${local.provider_path.management_groups}${each.value.parent_management_group_id}"
  depends_on                 = [azurerm_management_group.level_1]
  subscription_ids           = each.value.subscription_ids
}

## create level 3 mg
resource "azurerm_management_group" "level_3" {
  for_each                   = local.azurerm_management_group_level_3
  name                       = each.value.id
  display_name               = each.value.display_name
  parent_management_group_id = "${local.provider_path.management_groups}${each.value.parent_management_group_id}"
  depends_on                 = [azurerm_management_group.level_2]
  subscription_ids           = each.value.subscription_ids
}

## create level 4 mg
resource "azurerm_management_group" "level_4" {
  for_each                   = local.azurerm_management_group_level_4
  name                       = each.value.id
  display_name               = each.value.display_name
  parent_management_group_id = "${local.provider_path.management_groups}${each.value.parent_management_group_id}"
  depends_on                 = [azurerm_management_group.level_3]
  subscription_ids           = each.value.subscription_ids
}
