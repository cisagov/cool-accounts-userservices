# ------------------------------------------------------------------------------
# Provision SSM Session Manager and configure it for session logging.
# ------------------------------------------------------------------------------

module "session_manager" {
  source = "github.com/cisagov/session-manager-tf-module?ref=first-commits"

  other_accounts = [
    local.users_account_id,
  ]
}
