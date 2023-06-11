############################################################################
############################################################################
# Update the section below with the required variable to run your modules
# in the main.tf file. Please read the readme.rd file for the required 
# variables settings.
############################################################################
############################################################################

#### Varialbes for Management groups module
## Management Group root name and ID
variable "root_id" {
  type    = string
  default = "mg_global"
}

variable "root_parent_id" {
  type    = string
  default = "6603f62a-2c40-4809-8acb-bd99553cc6ab" #TODO
}

## MG structure for all levels under root
variable "management_groups" {
  type = map(any)
  default = {
    ## MG ID for root level
    mg_global = {
      ## MG Name
      display_name               = "Global"
      parent_management_group_id = "6603f62a-2c40-4809-8acb-bd99553cc6ab" #TODO
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 2
    mg_level_2a = {
      display_name = "Level 2A"
      ## the parent MG ID need to be the ID of
      parent_management_group_id = "mg_global"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 2
    mg_level_2b = {
      display_name               = "Level 2B"
      parent_management_group_id = "mg_global"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 2
    mg_level_2c = {
      display_name               = "Level 2C"
      parent_management_group_id = "mg_global"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 2
    mg_level_2d = {
      display_name               = "Level 2D"
      parent_management_group_id = "mg_global"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 3
    mg_level_3a = {
      display_name               = "Level 3A"
      parent_management_group_id = "mg_level_2a"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 3
    mg_level_3b = {
      display_name               = "Level 3B"
      parent_management_group_id = "mg_level_2a"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 3
    mg_level_3c = {
      display_name               = "Level 3C"
      parent_management_group_id = "mg_level_2a"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 4
    mg_level_4a = {
      display_name               = "Level 4A"
      parent_management_group_id = "mg_level_3a"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 4
    mg_level_4b = {
      display_name               = "Level 4B"
      parent_management_group_id = "mg_level_3a"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 4
    mg_level_4c = {
      display_name               = "Level 4C"
      parent_management_group_id = "mg_level_3b"
      subscription_names         = []
      canary_subscription_names  = []
    }
  }

}
## Canary switch, if you have it = true, the module will create the whole 
## hirachie structure of MG with the prefix of "canary-" replicate the above 
## MG structure.
variable "canary_required" {
  type    = bool
  default = true
}

############################################################################
## The section below defines the variables to assign policies to mg
############################################################################
## Assign NZISM 3.5 to root mg
variable "policy_assignments" {
  type = map(any)
  default = {
    nzism_built_in = {
      management_group_id  = "mg_global"
      display_name         = "NZISM"
      description          = "Assignment of the built in NZISM initiative to management group"
      policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/93d2179e-3068-c82f-2428-d614ae836a04"
      location             = "australiaeast"
      identity             = ["SystemAssigned"]
      enforcement_mode     = true
      non_compliance_message = {
        content = "Not Complicant"
      }
      not_scopes = "test"
      parameters = {
        "effect-1e66c121-a66a-4b1f-9b83-0fd99bf0fc2d" = {
          value = "Audit",
        }
      }
    },

    tag_governance = {
      management_group_id  = "mg_global"
      display_name         = "Tag Governance"
      description          = "Assignment of the custom tagging policies"
      policy_definition_id = "/providers/Microsoft.Management/managementGroups/mg_global/providers/Microsoft.Authorization/policySetDefinitions/tag_governance"
      location             = "australiaeast"
      identity             = ["SystemAssigned"]
      enforcement_mode     = true
      non_compliance_message = {
        content = "Not Complicant"
      }
      not_scopes = "test"
      parameters = {}
    }
  }
}

variable "resource_groups" {
  type = map(any)
  default = {
    TestRG = {
      location = "australiaeast",
      tags = {
        "ServiceName" = "TerrAHCOF"
        "Environment" = "DEV"
      }
      permissions = {}
    }
  }
}

variable "mandatory_tag_names" {
  type = list(any)
  default = [
    "ServiceName",
    "Environment"
  ]
}

variable "mandatory_tags_with_value_rules" {
  type    = list(string)
  default = ["ServiceName"]
}

variable "state_files_resource_group" {
  type    = string
  default = "rg-terrahcof-state-ae"
}

variable "state_file_storage_accounts" {
  type = map(any)
  default = {
    "BAU" = {
      business_unit = "BAU"
      environment   = "dev"
    }
  }
}

variable "storage_account_name" {
  type    = string
  default = "stterrahcofstateae"
}

