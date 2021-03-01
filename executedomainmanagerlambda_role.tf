# ------------------------------------------------------------------------------
# Create the IAM role that allows sufficient AWS permissions to execute
# Domain Manager Lambdas in the User Services account.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "executedomainmanagerlambda" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_lambda.json
  description        = var.executedomainmanagerlambda_role_description
  name               = var.executedomainmanagerlambda_role_name
  tags               = var.tags
}
