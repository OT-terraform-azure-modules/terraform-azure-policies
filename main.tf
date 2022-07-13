provider "azurerm" {
  features {}
}

resource "azurerm_policy_definition" "policy" {
  count               = var.policy_type == "Custom" && var.policy_manner == "Policy" ? 1 : 0
  name                = var.policy_name
  policy_type         = var.policy_type
  mode                = var.mode
  display_name        = var.policy_display_name
  description         = var.policy_description
  policy_rule         = jsonencode(var.policy_rule)
  parameters          = jsonencode(var.policy_parameters)
  metadata            = jsonencode(var.metadata)
  management_group_id = var.management_group_id
}

resource "azurerm_policy_set_definition" "initiative_policy" {
  count               = var.policy_type == "Custom" && var.policy_manner == "Initiative" ? 1 : 0
  name                = var.policy_name
  display_name        = var.policy_display_name
  description         = var.policy_description
  policy_type         = var.policy_type
  parameters          = jsonencode(var.policy_parameters)
  metadata            = jsonencode(var.metadata)
  management_group_id = var.management_group_id

  dynamic "policy_definition_reference" {
    for_each = var.initiative_policy_definition_reference
    content {
        policy_definition_id = lookup(policy_definition_reference.value,"policyID")
        parameter_values     = lookup(policy_definition_reference.value,"parameter_values", null)
        reference_id         = lookup(policy_definition_reference.value,"reference_id", null)
        policy_group_names   = lookup(policy_definition_reference.value,"policy_group_names", null)
    }
  }

  dynamic "policy_definition_group" {
    for_each = var.initiative_policy_definition_group
    content {
      name                              = lookup(policy_definition_group.value,"name")
      display_name                      = lookup(policy_definition_group.value,"display_name", null)
      category                          = lookup(policy_definition_group.value,"category", null)
      description                       = lookup(policy_definition_group.value,"description", null)
      additional_metadata_resource_id   = lookup(policy_definition_group.value,"metadata_resource_id", null)
    }
  }
}

resource "azurerm_resource_group_policy_assignment" "assign_policy_rg" {
  count                = var.policy_def_scope_type == "resource-group" ? 1 : 0
  name                 = var.policy_assignment_name
  policy_definition_id = try(azurerm_policy_definition.policy[0].id , azurerm_policy_set_definition.initiative_policy[0].id)
  resource_group_id    = var.resource_group_id
  location             = var.assignment_location
  description          = var.assignment_description
  display_name         = var.assignment_display_name
  enforce              = var.assignment_enforcement_mode
  metadata             = jsonencode(var.assignment_metadata)
  parameters           = jsonencode(var.assignment_parameters)
  not_scopes           = var.assignment_not_scopes

  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : null
  }
}

resource "azurerm_resource_policy_assignment" "assign_policy_resource" {
  count                = var.policy_def_scope_type == "resource" ? 1 : 0
  name                 = var.policy_assignment_name
  policy_definition_id = try(azurerm_policy_definition.policy[0].id , azurerm_policy_set_definition.initiative_policy[0].id)
  resource_id          = try(var.resource_id, null) 
  location             = var.assignment_location
  display_name         = var.assignment_display_name
  description          = var.assignment_description
  parameters           = jsonencode(var.assignment_parameters)
  metadata             = jsonencode(var.assignment_metadata)
  enforce              = var.assignment_enforcement_mode
  not_scopes           = var.assignment_not_scopes

  identity {
    type         = var.identity_type
     identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : null
  }
}

resource "azurerm_management_group_policy_assignment" "assign_policy_mgmt" {
  count                = var.policy_def_scope_type == "management-group" ? 1 : 0
  name                 = var.policy_assignment_name
  policy_definition_id = try(azurerm_policy_definition.policy[0].id , azurerm_policy_set_definition.initiative_policy[0].id)
  management_group_id  = var.management_group_id
  location             = var.assignment_location
  display_name         = var.assignment_display_name
  description          = var.assignment_description
  parameters           = jsonencode(var.assignment_parameters)
  metadata             = jsonencode(var.assignment_metadata)
  enforce              = var.assignment_enforcement_mode
  not_scopes           = var.assignment_not_scopes

  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : null
  }
}

resource "azurerm_subscription_policy_assignment" "assign_policy_sub" {
  count                = var.policy_def_scope_type == "subscription" ? 1 : 0
  name                 = var.policy_assignment_name
  policy_definition_id = try(azurerm_policy_definition.policy[0].id , azurerm_policy_set_definition.initiative_policy[0].id)
  subscription_id      = var.subscription_id
  location             = var.assignment_location
  display_name         = var.assignment_display_name
  description          = var.assignment_description
  parameters           = jsonencode(var.assignment_parameters)
  metadata             = jsonencode(var.assignment_metadata)
  enforce              = var.assignment_enforcement_mode
  not_scopes           = var.assignment_not_scopes

  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : null
  }
}