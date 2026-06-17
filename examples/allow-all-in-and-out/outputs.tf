output "resource" {
  description = <<DESCRIPTION
  The full Subscriptions Policies azapi_update_resource.
  DESCRIPTION

  value = module.suscriptions_policies.resource
}

output "resource_id" {
  description = <<DESCRIPTION
  The ID of the Subscriptions Policies.
  DESCRIPTION

  value = module.suscriptions_policies.resource_id
}
