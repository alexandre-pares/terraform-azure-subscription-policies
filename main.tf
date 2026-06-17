# Microsoft.Subscription policies
# Learn more: https://learn.microsoft.com/en-us/azure/templates/microsoft.subscription/policies
resource "azapi_update_resource" "this" {
  type = "Microsoft.Subscription/policies@2025-11-01-preview"
  name = "default"

  parent_id = "/"

  body = {
    blockSubscriptionsLeavingTenant = !var.enable_all_users_to_transfer_out
    blockSubscriptionsIntoTenant    = !var.enable_all_users_to_transfer_in
    exemptedPrincipals              = var.bypass_user_list
  }
}
