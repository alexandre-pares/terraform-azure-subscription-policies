module "suscriptions_policies" {
  source = "../.."

  enable_all_users_to_transfer_in  = true
  enable_all_users_to_transfer_out = true
  bypass_user_list                 = []
}
