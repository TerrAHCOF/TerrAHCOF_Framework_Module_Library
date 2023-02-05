############################################################################
############################################################################
# Update the section below with the required variable to run your modules
# in the main.tf file. Please read the readme.rd file for the required 
# variables settings.
############################################################################
############################################################################

#### Varialbes for Management groups module
## MG root name and ID
variable "root_id" {
  type    = string
  default = "mg_global"
}

variable "root_parent_id" {
  type    = string
  default = "" #TODO
}

## MG structure for all levels under root
variable "management_groups" {
  type = map(any)
  default = {
    ## MG ID for root level
    mg_global = {
      ## MG Name
      display_name               = "Global"
      parent_management_group_id = "" #TODO
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 2
    mg_pcs = {
      display_name = "Platform Common Services"
      ## the parent MG ID need to be the ID of
      parent_management_group_id = "mg_global"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 2
    mg_bus = {
      display_name               = "Application Landing Zones"
      parent_management_group_id = "mg_global"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 2
    mg_sandbox = {
      display_name               = "Sandbox"
      parent_management_group_id = "mg_global"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 2
    mg_decomm = {
      display_name               = "Decom"
      parent_management_group_id = "mg_global"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 3
    mg_pcs_identity = {
      display_name               = "Identity"
      parent_management_group_id = "mg_pcs"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 3
    mg_pcs_management = {
      display_name               = "Management"
      parent_management_group_id = "mg_pcs"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 3
    mg_pcs_connectivity = {
      display_name               = "Connectivity"
      parent_management_group_id = "mg_pcs"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 3
    mg_prod_services = {
      display_name               = "Production Services"
      parent_management_group_id = "mg_bus"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 3
    mg_nonprod_services = {
      display_name               = "Non-Prod Services"
      parent_management_group_id = "mg_bus"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 4
    mg_prod = {
      display_name               = "Production"
      parent_management_group_id = "mg_prod_services"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 4
    mg_preprod = {
      display_name               = "Pre-Production"
      parent_management_group_id = "mg_prod_services"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 4
    mg_standard = {
      display_name               = "UAT/SIT"
      parent_management_group_id = "mg_nonprod_services"
      subscription_names         = []
      canary_subscription_names  = []
    }
    ## MG ID for Level 4
    mg_dev = {
      display_name               = "Development"
      parent_management_group_id = "mg_nonprod_services"
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
    }
  }
}

variable "resource_groups" {
  type = map(any)
  default = {
    TestRG = {
      location = "australiaeast",
      tags = {
        "Environment" = "DEV"
      }
      permissions = {}
    }
  }
}


