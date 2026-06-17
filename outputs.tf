output "resource" {
  description = <<DESCRIPTION
  The full Subscriptions Policies azapi_update_resource.
  DESCRIPTION

  value = azapi_update_resource.this
}

output "resource_id" {
  description = <<DESCRIPTION
  The ID of the Subscriptions Policies.
  DESCRIPTION

  value = azapi_update_resource.this.id
}
