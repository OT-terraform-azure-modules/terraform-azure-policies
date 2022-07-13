Azure Policy Terraform Module
=====================================

[![Opstree Solutions][opstree_avatar]][opstree_homepage]

[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

- This terraform module will create azure policy and initiative policy.
- This project is a part of opstree's ot-azure initiative for terraform modules.

## Information:

Terraform Module to create an Azure policy with a set of policy as initiative or by creating a custom policy. 

- The creation of policy depends on the `policy_manner` variable . 
### Case1:
  When `policy_manner` = Policy , then it will create a single policy. 
### Case2:
  When `policy_manner` = Initiative , then you have to provide policy_definition_id of the set of policy that you want to combine. 

## Resources supported:

* [Policy definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition)
* [Policy set definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_set_definition)
* [Resource group policy assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_assignment)
* [Resource policy assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_assignment)
* [Management group policy assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment)
* [Subscription policy assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment)

## Case 1: Module Usage for azure policy 

```hcl
provider "azurerm" {
  features {}
}

module "policy" {
  source              = "../../"
  policy_manner       = "Policy"
  policy_name         = "test"
  policy_type         = "Custom"
  mode                = "All"
  policy_display_name = "test policy"
  policy_rule         = {
    "if" : {
      "not" : {
        "field" : "location"
        "in" : "[parameters('allowedLocations')]"
      }
    },
    "then" : {
      "effect" : "deny"
    }
  }
  policy_parameters   = {
    "allowedLocations" : {
      "type" : "Array",
      "metadata" : {
        "description" : "The list of allowed locations for resources.",
        "displayName" : "Allowed locations",
        "strongType" : "location"
      }
    }
  }
  metadata            = {
    "category" : "General"
  }

  policy_def_scope_type  = "subscription"
  policy_assignment_name = "testassign"
  subscription_id      = "/subscriptions/4c93bx9q-1cbc-4230-8418-f8df57419q1a"
  assignment_location    = "eastus"
  assignment_parameters  = {
          "allowedLocations": {
            "value": [ "West Europe" ]
          }
        }
}
```
## Case 2: Module Usage for initiative policy 

```hcl
module "policy" {
  source              = "../../"
  policy_manner       = "Initiative"
  policy_name         = "test"
  policy_type         = "Custom"
  policy_display_name = "test policy"
  metadata = {
    "category" : "General"
  }
  initiative_policy_definition_reference = [{
    "policyID" = "/providers/Microsoft.Authorization/policyDefinitions/06a78e20-9358-41c9-923c-fb736d382a4d"
    "reference_id" = "Audit VMs that do not use managed disks"
  },
  {
    "policyID" = "/providers/Microsoft.Authorization/policyDefinitions/0015ea4d-51ff-4ce3-8d8c-f3f8f0179a56"
    "reference_id" = "Audit virtual machines without disaster recovery configured"
  }]
  policy_def_scope_type  = "resource-group"
  policy_assignment_name = "testassign"
  resource_group_id      = "/subscriptions/4c93bx9q-1cbc-4230-8418-f8df57419q1a/resourceGroups/test_rg"
  assignment_location    = "eastus"
}
```

Inputs
------
 Name | Description | Type | Default | Required 
------|-------------|------|---------|:--------:
`policy_name` |  The name of the policy definition. | `string` |  | Yes 
`policy_type` | The type of policy, possible values are BuiltIn, Custom and NotSpecified. | `string` | Custom | Yes
`policy_manner ` | Kind of policy , possible values are Policy and Initiative | `string` || Yes
`policy_display_name` | The display name of the policy definition | `string` | | Yes
`policy_description` |  The description of the policy definition | `string` | null | No 
`mode` | The policy mode that allows you to specify which resource types will be evaluated | `string` | All | Yes
`policy_rule` | The JSON string of policy rule for the policy definition. | `any` | | Yes
`parameters` | Parameters of JSON string for the policy definition | `any` | null | No
`metadata` |  Metadata of JSON string for the policy definition | `any` | null | No
`management_group_id` |  The id of the Management Group where this policy should be defined. | `string` | null | No
`policy_def_scope_type` | The scope on which policy should be assigned. | `string` | | Yes
`policy_assignment_name` |  The name which should be used for this policy assignment.| `string` | | Yes
`resource_group_id` | The ID of the resource group where the policy assignment should be created. | `string` | null | No
`resource_id` | The ID of the Resource where the policy assignment should be created. | `string` | null | No
`management_group_id` | The ID of the management group where the policy assignment should be created. | `string` | null | No
`subscription_id` | The ID of the subscription group where the policy assignment should be created. | `string` | null | No
`policy_definition_id` | The ID of the Policy Definition to be applied at the specified Scope. | `string` | | Yes
`assignment_location` | The Azure location where this policy assignment should exist. | `string` | | Yes
`assignment_description` |  A description which should be used for this Policy Assignment. | `string` | null | No
`assignment_display_name` | The Display Name for this Policy Assignment. | `string` | null | No 
`assignment_enforcement_mode` | Specifies if this Policy should be enforced or not | `bool` | true | No 
`assignment_metadata` | A JSON mapping of any Metadata for this Policy. | `any` | null | No 
`assignment_parameters` | A JSON mapping of any Parameters for this Policy. | `any` | null | No
`assignment_not_scopes` | Specifies a list of Resource Scopes within this Management Group which are excluded from this Policy. | `list(string)` | [] | No 
`identity_ids` | A list of User Managed Identity IDs which should be assigned to the Policy Definition. | `list(string)` | [] | No
`identity_type` | The Type of Managed Identity which should be added to the Policy Definition. | `string` | SystemAssigned | Yes
`initiative_policy_definition_reference` | List of policy definitions for initiative policy.  | `any` | [] | Yes 
`initiative_policy_definition_group` | List of policy definition group for initiative policy. | `any`| [] | No

## For policy assignment
When `policy_def_scope_type`  = resource-group then,  `resource_group_id` should be in the below format:

> `resource_group_id` : "/subscriptions/subscription_id/resourceGroups/resource_group_name" 

When `policy_def_scope_type` = resource then,  `resource_id` should be in the below format:

> `resource_id` : "/subscriptions/subscription_id/resourceGroups/resource_group_name/providers/Microsoft.Network/resourceType/resourcename" 

When `policy_def_scope_type` = management-group then, `management_group_id` should be in the below format:

> `management_group_id` : "/providers/Microsoft.Management/managementGroups/management_group_id" 

When `policy_def_scope_type` = subscription then, `subscription_id` should be in the below format:

> `subscription_id` : "/subscriptions/subscription_id" 

## Outputs

Name | Description
---- | -----------
`policy_definition_id`| The ID of the policy definition
`policy_definition_name`| The name of the policy definition
`policy_initiative_definition_id`| The ID of the initiative policy definition
`policy_initiative_definition_name`| The name of the initiative policy definition
`resource_policy_assignment_id`|  The ID of the resource policy assignment 
`resource_group_policy_assignment_id`|  The ID of the resource group policy assignment 
`management_group_policy_assignment_id` | The ID of the management group policy assignment 
`subscription_group_policy_assignment_id` | The ID of the subscription group policy assignment

### **Contributors**

[himanshi_homepage]: https://github.com/himanshiparnami
[himanshi_avatar]: https://avatars.githubusercontent.com/u/101627875?s=200&v=4

**[![Himanshi Parnami][himanshi_avatar]][himanshi_homepage]<br/>[Himanshi Parnami][himanshi_homepage]** 