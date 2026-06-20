# Azure Subscription Policies Terraform module for Microsoft Azure

Terraform module to manage Azure Subscription Policies, including transfer in or out and bypass user list.

Using this module you can:

- Enable/Disable users to transfer out Azure Subscriptions into your Azure tenant.
- Enable/Disable users to transfer in Azure Subscriptions into your Azure tenant.
- Allow specific users to bypass above settings.

Learn more: https://aka.ms/subPolicy

# Usage

Detailed examples are available under the [`./examples`](./examples/) directory.

```hcl
module "subscription_policies" {
  source  = "alexandre-pares/subscription-policies/azure"
  version = "1.0.0"

  # Recommended settings
  enable_all_users_to_transfer_in   = false
  enable_all_users_to_transfer_out  = false
  bypass_user_list = [ ]
}
```

# Requirements

Per [Microsoft documentation](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/manage-azure-subscription-policy#prerequisites), only [Global Administrators](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/permissions-reference#global-administrator) can edit subscription policies. Other users can read the current subscription policy setting.

If you are using a managed identity (e.g. UAMI for GitHub Action), you will need to add the elevated role assignment to the identity:

1. Find the object ID of your user-assigned managed identity (not the client id)
2. Using an account with elevated access, run the following command:

```bash
# Replace with the Object ID of your user-assigned managed identity
uami_object_id="replace_me"

# Grant elevetated access (User Access Administrator) to your user-assigned managed identity
az role assignment create --scope "/" --role "User Access Administrator" --assignee $uami_object_id
```

3. Run your Terraform pipeline
4. Remove the elevated access. Using an account with elevated access, run the following command:

```bash
# Remove the elevated access
az role assignment delete --scope "/" --role "User Access Administrator" --assignee $uami_object_id
```

# Common errors

## User doesn't have 'UserAccessAdministrator' role at root scope (/)

As mentionned in the requirements above, you need to grant elevated access to the identity execuring the Terraform module.

If you're using your own account (not recommended), you need to elevate your access by following [this procedure](https://learn.microsoft.com/en-us/azure/role-based-access-control/elevate-access-global-admin).

If you're using a managed identity (recommended), you can follow the procedure mentionned above (requirements) to assign, execute and then remove the elevated access.

```bash
╷
│ Error: Failed to update resource
│
│   with module.subscription_policy.azapi_update_resource.this,
│   on .terraform/modules/subscription_policy/main.tf line 3, in resource "azapi_update_resource" "this":
│    3: resource "azapi_update_resource" "this" {
│
│ updating "Resource: (ResourceId
│ \"/providers/Microsoft.Subscription/policies/default\" / Api Version
│ \"2025-11-01-preview\")": PUT
│ https://management.azure.com/providers/Microsoft.Subscription/policies/default
│ --------------------------------------------------------------------------------
│ RESPONSE 401: 401 Unauthorized
│ ERROR CODE: UserNotAuthorized
│ --------------------------------------------------------------------------------
│ {
│   "error": {
│     "code": "UserNotAuthorized",
│     "message": "User doesn't have 'UserAccessAdministrator' role at root scope (/)"
│   },
│   "code": "UserNotAuthorized",
│   "message": "User doesn't have 'UserAccessAdministrator' role at root scope (/)"
│ }
│ --------------------------------------------------------------------------------
│
╵
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.15 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~> 2.10 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | ~> 2.10 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azapi_update_resource.this](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/update_resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_bypass_user_list"></a> [bypass\_user\_list](#input\_bypass\_user\_list) | List of users Object ID that can bypass subscription policies.<br/><br/>  Groups aren't yet supported by the Microsoft API. | `list(string)` | n/a | yes |
| <a name="input_enable_all_users_to_transfer_in"></a> [enable\_all\_users\_to\_transfer\_in](#input\_enable\_all\_users\_to\_transfer\_in) | This policy controls if users can bring Azure subscriptions from a different Microsoft Entra tenant into this tenant.<br/><br/>    If `true`: Allow all users (including Guest Users) to add Azure subscriptions to this tenant.<br/>    If false`: Allow no users (except elevated Global Admins) to add Azure subscriptions to this tenant (recommended).<br/><br/>    Learn more: https://aka.ms/subPolicy<br/>` | `bool` | n/a | yes |
| <a name="input_enable_all_users_to_transfer_out"></a> [enable\_all\_users\_to\_transfer\_out](#input\_enable\_all\_users\_to\_transfer\_out) | Subscription leaving this Microsoft Entra ID:<br/>    This policy controls if users can change the Microsoft Entra tenant of Azure subscriptions from this tenant to a different one.<br/><br/>    If true: Allow all users (including Guest Users) with subscription owner RBAC permissions to move Azure subscriptions from this Microsoft Entra ID to another tenant.<br/>    If `false`: Allow no users (except elevated Global Admins) to move Azure subscriptions from this Microsoft Entra ID to another tenant (recommended).<br/><br/>    Learn more: https://aka.ms/subPolicy | `bool` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_resource"></a> [resource](#output\_resource) | The full Subscriptions Policies azapi\_update\_resource. |
| <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id) | The ID of the Subscriptions Policies. |
<!-- END_TF_DOCS -->
