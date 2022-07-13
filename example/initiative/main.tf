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
