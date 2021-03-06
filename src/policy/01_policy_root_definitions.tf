resource "azurerm_policy_definition" "tags_inherit_from_subscription" {

  for_each = toset(var.tags_subscription_to_inherith)

  name                = "pagopa_tag_${lower(each.key)}_inherit_from_subscription"
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "PagoPA: Tag ${each.key} inherith from subscription"
  management_group_id = data.azurerm_management_group.root_sl_pagamenti_servizi.id

  metadata = <<METADATA
    {
        "category": "${var.metadata_category_name}",
        "version": "v1.0.0"
    }
METADATA

  policy_rule = <<POLICY_RULE
    {
      "if": {
        "allOf": [
          {
            "field": "[concat('tags[', parameters('tagName'), ']')]",
            "exists": "false"
          },
          {
            "value": "[subscription().tags[parameters('tagName')]]",
            "notEquals": ""
          }
        ]
      },
      "then": {
        "effect": "modify",
        "details": {
          "roleDefinitionIds": [
            "/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
          ],
          "operations": [
            {
              "operation": "add",
              "field": "[concat('tags[', parameters('tagName'), ']')]",
              "value": "[subscription().tags[parameters('tagName')]]"
            }
          ]
        }
      }
    }
POLICY_RULE


  parameters = <<PARAMETERS
    {
      "tagName": {
        "type": "String",
        "metadata": {
          "displayName": "Tag Name",
          "description": "Name of the tag, such as 'environment'"
        },
        "defaultValue": "${each.key}"
      }
    }
PARAMETERS

}
