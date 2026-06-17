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
module "subscriptions_policies" {
  source  = "alexandre-pares/subscription-policies/azure"
  version = "1.0.0"

  # Recommended settings
  enable_all_users_to_transfer_in   = false
  enable_all_users_to_transfer_out  = false
  bypass_user_list = [ ]
}

# Requirements

Per [Microsoft documentation](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/manage-azure-subscription-policy#prerequisites), only [Global Administrators](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/permissions-reference#global-administrator) can edit subscription policies. Other users can read the current subscription policy setting.

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
