variable "enable_all_users_to_transfer_in" {
  description = <<DESCRIPTION
    This policy controls if users can bring Azure subscriptions from a different Microsoft Entra tenant into this tenant.

    If `true`: Allow all users (including Guest Users) to add Azure subscriptions to this tenant.
    If false`: Allow no users (except elevated Global Admins) to add Azure subscriptions to this tenant (recommended).

    Learn more: https://aka.ms/subPolicy
    DESCRIPTION

  type     = bool
  nullable = false
}

variable "enable_all_users_to_transfer_out" {
  description = <<DESCRIPTION
    Subscription leaving this Microsoft Entra ID:
    This policy controls if users can change the Microsoft Entra tenant of Azure subscriptions from this tenant to a different one.

    If true: Allow all users (including Guest Users) with subscription owner RBAC permissions to move Azure subscriptions from this Microsoft Entra ID to another tenant.
    If `false`: Allow no users (except elevated Global Admins) to move Azure subscriptions from this Microsoft Entra ID to another tenant (recommended).

    Learn more: https://aka.ms/subPolicy
    DESCRIPTION

  type     = bool
  nullable = false
}

variable "bypass_user_list" {
  description = <<DESCRIPTION
  List of users Object ID that can bypass subscription policies.

  Groups aren't yet supported by the Microsoft API.
  DESCRIPTION

  type     = list(string)
  nullable = false
}
