locals {
  empty_list = []
  empty_map  = tomap({})
  provider_path = {
    management_groups = "/providers/Microsoft.Management/managementGroups/"
  }

  metadata = <<METADATA
    {
    "category": "Tag Governance",
    "version" : "1.0.0"
    }
  METADATA



  requireTag_policy_rule_definition = {
    "if" = {
      "allOf" = [
        {
          "field"  = "type",
          "equals" = "Microsoft.Resources/subscriptions/resourceGroups"
        },
        {
          "anyOf" = [
            for value in var.mandatory_tag_names :
            {
              "field"  = "[concat('tags[', parameters('${value}'), ']')]",
              "exists" = "false",
            }
          ]
        }
      ]
    },
    "then" = {
      "effect" = "[parameters('effect')]"
    }
  }

  inheritTag_policy_rule_definition = {
    "if" = {
      "anyOf" = [
        for value in var.mandatory_tag_names :
        {
          "field"  = "[concat('tags[', parameters('${value}'), ']')]",
          "exists" = "false",
        }
      ]
    },
    "then" = {
      "effect" = "modify",
      "details" = {
        "roleDefinitionIds" = [
          "/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
        ],
        "operations" = [
          for value in var.mandatory_tag_names :
          {
            "operation" : "add",
            "field" : "[concat('tags[', parameters('${value}'), ']')]",
            "value" : "[resourceGroup().tags[parameters('${value}')]]"
          }
        ]
      }
    }
  }

  inheritTagValues_policy_rule_definition = {
    "if" = {
      "anyOf" = [
        for value in var.mandatory_tag_names :
        {
          "value"     = "[resourceGroup().tags[parameters('${value}')]]",
          "notEquals" = "",
        }
      ]
    },
    "then" = {
      "effect" = "modify",
      "details" = {
        "roleDefinitionIds" = [
          "/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
        ],
        "operations" = [
          for value in var.mandatory_tag_names :
          {
            "operation" : "add",
            "field" : "[concat('tags[', parameters('${value}'), ']')]",
            "value" : "[resourceGroup().tags[parameters('${value}')]]"
          }
        ]
      }
    }
  }

  tagsWithValueRules_policy_rule_definition = {
    "if" = {
      "allOf" = [
        {
          "field"  = "type",
          "equals" = "Microsoft.Resources/subscriptions/resourceGroups"
        },
        {
          "anyOf" = [
            for value in var.mandatory_tags_with_value_rules :
            {
              "field" = "[concat('tags[', parameters('${value}'), ']')]",
              "in"    = "[parameters('notAllowedValues')]"
            }
          ]
        }
      ]
    },
    "then" = {
      "effect" = "[parameters('effect')]"
    }
  }

  parameters_definition = {
    for value in var.mandatory_tag_names :
    "${value}" => {
      "type" = "String",
      "metadata" = {
        "displayName" = "Require tag ${value} on a resource groups",
        "description" = "Name of the mandatory tag ${value}."
      },
      "defaultValue" = "${value}"
    }
  }

  effect_definition = {
    "effect" = {
      "type" = "String",
      "metadata" = {
        "displayName" = "Effect",
        "description" = "Enable or disable the execution of the policy."
      },
      "defaultValue" = "Deny"
    }
  }

  notAllowedValues_definition = {
    "notAllowedValues" : {
      "type" = "Array",
      "metadata" = {
        "displayName" = "Tag values not allowed for tags",
        "description" = "A list of tag values that are not acceptable for tags"
      },
      "defaultValue" : "${var.tag_values_not_allowed}"
    }
  }

  tagsWithValueRules_parameters_definition = {
    for value in var.mandatory_tags_with_value_rules :
    "${value}" => {
      "type" = "String",
      "metadata" = {
        "displayName" = "Mandatory tag ${value}",
        "description" = "Name of the mandatory tag ${value}."
      },
      "defaultValue" = "${value}"
    }
  }



  parameters_map                   = merge(local.parameters_definition, local.effect_definition)
  parameters_tagwithValueRules_map = merge(local.tagsWithValueRules_parameters_definition, local.effect_definition, local.notAllowedValues_definition)

  requireTag_policy_rule                   = jsonencode(local.requireTag_policy_rule_definition)
  inheritTags_policy_rule                  = jsonencode(local.inheritTag_policy_rule_definition)
  inheritTagValues_policy_rule             = jsonencode(local.inheritTagValues_policy_rule_definition)
  tagsWithValueRules_policy_rule           = jsonencode(local.tagsWithValueRules_policy_rule_definition)
  parameters                               = jsonencode(local.parameters_definition)
  parameters_withEffect                    = jsonencode(local.parameters_map)
  tagsWithValueRules_parameters_withEffect = jsonencode(local.parameters_tagwithValueRules_map)
}

resource "azurerm_policy_definition" "requireTagsOnRG" {
  name                = "requireTagsOnRG"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "Require tags on resource groups"
  description         = "Enforces existence of tags on resource groups."
  management_group_id = "${local.provider_path.management_groups}${var.policy_definition_scope_id}"
  metadata            = local.metadata
  policy_rule         = local.requireTag_policy_rule
  parameters          = local.parameters_withEffect
}

resource "azurerm_policy_definition" "inheritTagsFromRG" {
  name                = "inheritTagsFromRG"
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "Inherit tags from the resource group"
  description         = "Adds the mandatory tags from the parent resource group when any resource missing this tag is created or updated. Existing resources can be remediated by triggering a remediation task. If the tags exists with a different value it will not be changed."
  management_group_id = "${local.provider_path.management_groups}${var.policy_definition_scope_id}"
  metadata            = local.metadata
  policy_rule         = local.inheritTags_policy_rule
  parameters          = local.parameters
}

resource "azurerm_policy_definition" "inheritTagValuesFromRG" {
  name                = "inheritTagValuesFromRG"
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "Inherit tag values from the resource group"
  description         = "Adds the mandatory tags with its value from the parent resource group when any resource missing this tag is created or updated. Existing resources can be remediated by triggering a remediation task. If the tags exists with a different value it will not be changed."
  management_group_id = "${local.provider_path.management_groups}${var.policy_definition_scope_id}"
  metadata            = local.metadata
  policy_rule         = local.inheritTagValues_policy_rule
  parameters          = local.parameters
}

resource "azurerm_policy_definition" "tagsWithValueRules" {
  name                = "tagsWithValueRules"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "Mandatory tags with Value rules"
  description         = "Enforces that the specified mandatory tags are not allowed specific values."
  management_group_id = "${local.provider_path.management_groups}${var.policy_definition_scope_id}"
  metadata            = local.metadata
  policy_rule         = local.tagsWithValueRules_policy_rule
  parameters          = local.tagsWithValueRules_parameters_withEffect
}
