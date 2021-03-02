# ------------------------------------------------------------------------------
# Create the IAM policy that allows sufficient AWS permissions to execute
# Domain Manager ECS in the User Services account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "executedomainmanagerecs" {
  statement {
    actions = [
      "ssm:GetParameters",
    ]

    resources = [
      "arn:aws:ssm:*:${local.userservices_account_id}:parameter/domain-manager/*",
    ]
  }
}

resource "aws_iam_policy" "executedomainmanagerecs" {
  description = var.executedomainmanagerecs_role_description
  name        = var.executedomainmanagerecs_role_name
  policy      = data.aws_iam_policy_document.executedomainmanagerecs.json
}
