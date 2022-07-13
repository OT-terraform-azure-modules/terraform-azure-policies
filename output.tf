output "policy_definition_id" {
  value       = azurerm_policy_definition.policy.*.id
  description = "Azure Policy definition id"
}

output "policy_definition_name" {
  value       = azurerm_policy_definition.policy.*.name
  description = "Azure Policy definition name"
}

output "policy_initiative_definition_id" {
  value       = azurerm_policy_set_definition.initiative_policy.*.id
  description = "Azure Initiative Policy definition id"
}

output "policy_initiative_definition_name" {
  value       = azurerm_policy_set_definition.initiative_policy.*.name
  description = "Azure Initiative Policy definition name"
}

output "resource_policy_assignment_id" {
  value       = azurerm_resource_policy_assignment.assign_policy_resource.*.id
  description = "Azure resource policy assignment id"
}

output "resource_group_policy_assignment_id" {
  value       = azurerm_resource_group_policy_assignment.assign_policy_rg.*.id
  description = "Azure resource group policy assignment id"
}

output "management_group_policy_assignment_id" {
  value       = azurerm_management_group_policy_assignment.assign_policy_mgmt.*.id
  description = "Azure management group policy assignment id"
}

output "subscription_group_policy_assignment_id" {
  value       = azurerm_subscription_policy_assignment.assign_policy_sub.*.id
  description = "Azure subscription group policy assignment id"
}