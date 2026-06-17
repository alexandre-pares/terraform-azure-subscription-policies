# Deny moving in and moving out Azure Subscriptions from your tenant except current user

This examples assumes that the Terraform script is executed using an user account (not a managed identity).

![Deny all users except current](../../assets/deny-all-with-bypass-user.png)

# Usage

```hcl
# Get current user properties
data "azapi_client_config" "current" {
}

module "suscriptions_policies" {
  source = "../.."

  # Deny all
  enable_all_users_to_transfer_in = false
  enable_all_users_to_transfer_out = false

  # Add current user Object ID to the bypass list
  bypass_user_list = [ data.azapi_client_config.current.object_id ]
}
```

Then run the following commands to deploy the export:

```bash
# Init Terraform
terraform init

# Plan changes
terraform plan

# Apply
terraform apply
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

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_suscriptions_policies"></a> [suscriptions\_policies](#module\_suscriptions\_policies) | ../.. | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azapi_client_config.current](https://registry.terraform.io/providers/Azure/azapi/latest/docs/data-sources/client_config) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_resource"></a> [resource](#output\_resource) | The full Subscriptions Policies azapi\_update\_resource. |
| <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id) | The ID of the Subscriptions Policies. |
<!-- END_TF_DOCS -->
