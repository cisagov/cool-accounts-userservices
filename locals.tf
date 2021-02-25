# ------------------------------------------------------------------------------
# Retrieve the effective Account ID, User ID, and ARN in which Terraform is
# authorized.  This is used to determine the User Services account ID.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "userservices" {}

# ------------------------------------------------------------------------------
# Evaluate expressions for use throughout this configuration.
# ------------------------------------------------------------------------------
locals {
  # Get the User Services account ID.
  userservices_account_id = data.aws_caller_identity.userservices.id
}
