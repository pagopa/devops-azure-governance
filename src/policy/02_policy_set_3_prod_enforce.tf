# Enforced
resource "azurerm_policy_set_definition" "prod_set_enforced" {
  name                = "pagopa_prod_set_enforced"
  policy_type         = "Custom"
  display_name        = "PagoPA/PROD/set/enforce@prod management group"
  management_group_id = data.azurerm_management_group.prod_sl_pagamenti_servizi.group_id

  metadata = <<METADATA
    {
        "category": "${var.metadata_category_name}",
        "version": "v1.0.0"
    }
  METADATA

  parameters = <<PARAMETERS
  {
    "listOfAllowedLocations": {
      "type": "Array",
      "metadata": {
        "description": "The list of locations that can be specified when deploying resources.",
        "strongType": "location",
        "displayName": "Allowed locations"
      },
      "defaultValue" : [""]
    }
  }
  PARAMETERS

  # Allowed Locations
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
    parameter_values     = <<VALUE
    {
      "listOfAllowedLocations": {
        "value": "[parameters('listOfAllowedLocations')]"
      }
    }
    VALUE
  }

  # Allowed locations for resource groups
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e765b5de-1225-4ba3-bd56-1ac6695af988"
    parameter_values     = <<VALUE
    {
      "listOfAllowedLocations": {
        "value": "[parameters('listOfAllowedLocations')]"
      }
    }
    VALUE
  }
}

#
# Asingment
#

locals {
  list_allowed_locations_prod = jsonencode(var.prod_allowed_locations)
}

resource "azurerm_management_group_policy_assignment" "prod_set_enforced_2_root_sl_pay" {
  name                 = "pa_prodsetenf2rootslpay"
  display_name         = "PagoPA/PROD/SET/ENFORCED 2 Mgmt root sl servizi e pagamenti"
  policy_definition_id = azurerm_policy_set_definition.prod_set_enforced.id
  management_group_id  = data.azurerm_management_group.prod_sl_pagamenti_servizi.id

  location = var.location
  enforce  = true

  metadata = <<METADATA
    {
        "category": "${var.metadata_category_name}",
        "version": "v1.0.0"
    }
  METADATA

  parameters = <<PARAMS
  {
      "listOfAllowedLocations": {
          "value": ${local.list_allowed_locations_prod}
      }
  }
  PARAMS

  identity {
    type = "SystemAssigned"
  }
}