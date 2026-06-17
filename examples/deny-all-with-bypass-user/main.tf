data "azapi_client_config" "current" {
}

module "suscriptions_policies" {
  source = "../.."

  enable_all_users_to_transfer_in  = false
  enable_all_users_to_transfer_out = false
  bypass_user_list                 = [data.azapi_client_config.current.object_id]
}
