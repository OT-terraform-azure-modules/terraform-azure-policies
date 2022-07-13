variable "policy_name" {
  type        = string
  description = "(Required) The name of the policy definition"
}

variable "policy_type" {
  type        = string
  description = "(Required)The intitative policy type. Possible values are BuiltIn or Custom. Changing this forces a new resource to be created"
  default     = "Custom"
}

variable "policy_manner" {
  type        = string
  description = "(Required)Simple policy or set of policy i.e., initiative. Values can be Policy or initiative"
}

variable "policy_display_name" {
  type        = string
  description = "(Required) The display name of the policy definition."
}

variable "mode" {
  type        = string
  default     = "All"
  description = "(Required) The policy mode that allows you to specify which resource types will be evaluated. Possible values are All, Indexed,"
}

variable "policy_description" {
  type        = string
  default     = null
  description = "(Optional) The description of the policy definition."
}

variable "policy_rule" {
  type        = any
  default     = null
  description = "(Required) The policy rule for the policy definition. This is a JSON string representing the rule that contains an if and a then block."
}

variable "policy_parameters" {
  type        = any
  default      = null
  description = "(Optional) Parameters for the policy definition. This field is a JSON string that allows you to parameterize your policy definition."
}

variable "metadata" {
  type        = any
  default     = null
  description = "(Optional) The metadata for the policy definition. This is a JSON string representing additional metadata that should be stored with the policy definition."
}

variable "policy_def_scope_type" {
  type        = string
  description = "(Required)The scope on which policy should be assigned . Possible values are resource-group, resource, management-group, subscription."
}

variable "policy_assignment_name" {
  type        = string
  description = "(Required) The name which should be used for this Policy Assignment"
}

variable "resource_group_id" {
  type        = string
  default     = null
  description = "The ID of the Resource Group where the Policy Assignment should be created. Resource group id should be in /subscriptions/subscription_id/resourceGroups/resource_group_name format."
}

variable "resource_id" {
  type        = string
  default     = null
  description = "The ID of the Resource where the Policy Assignment should be created. Resource group id should be in /subscriptions/subscription_id/resourceGroups/resource_group_name/providers/Microsoft.Network/virtualNetworks/test format."
}

variable "management_group_id" {
  type        = string
  default     = null
  description = "The ID of the Management Group where the Policy Assignment should be created. Management group id should be in /providers/Microsoft.Management/managementGroups/management_group_id format."
}

variable "subscription_id" {
  type        = string
  default     = null
  description = "The ID of the subscription Group where the Policy Assignment should be created. Subscription id should be in /subscriptions/subscription_id format."
}

variable "policy_definition_id" {
  type        = string
  description = "(Required) The ID of the Policy Definition to be applied at the specified Scope."
}

variable "assignment_location" {
  type        = string
  description = "(Required) The Azure location where this policy assignment should exist."
}

variable "assignment_description" {
  type        = string
  default     = null
  description = "(Optional) A description to use for this Policy Assignment."
}

variable "assignment_display_name" {
  type        = string
  default     = null
  description = "(Optional) A display name to use for this Policy Assignment."
}

variable "assignment_metadata" {
  type        = any
  default     = null
  description = "(Optional) A JSON mapping representing additional metadata that should be stored with the policy assignment."
}

variable "assignment_parameters" {
  type        = any
  default     = null
  description = "(Optional) Parameters for the policy definition. This field is a JSON string that maps to the Parameters field from the Policy Definition. "
}

variable "assignment_enforcement_mode" {
  type        = bool
  default     = true
  description = "(Optional) Can be set to 'true' or 'false' to control whether the assignment is enforced (true) or not (false). "
}

variable "assignment_not_scopes" {
  type        = list(string)
  description = "A list of the Policy Assignment's excluded scopes. Must be full resource IDs"
  default     = []
}

variable "identity_type" {
  type        = string
  default     = "SystemAssigned"
  description = "(Required) The Type of Managed Identity which should be added to the Policy Definition. Possible values are SystemAssigned and UserAssigned."
}

variable "identity_ids" {
  type        = list(string)
  default     = []
  description = "(Optional) A list of User Managed Identity IDs which should be assigned to the Policy Definition."
}

variable "initiative_policy_definition_reference" {
  type        = any
  description = "List of custom policy definitions"
  default = []
}

variable "initiative_policy_definition_group" {
  type        = any
  description = "List of initiative policy definition group"
  default     = []
}