# ------------------------------------------------------------------------------
# Create the IAM policy that allows sufficient permissions to provision
# all AWS resources for Domain Manager in the User Services account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisiondomainmanager_policy_doc" {
  statement {
    actions = [
      "ec2:DescribeSubnets",
      # TODO: Add remaining actions
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "provisiondomainmanager_policy" {
  description = var.provisiondomainmanager_role_description
  name        = var.provisiondomainmanager_role_name
  policy      = data.aws_iam_policy_document.provisiondomainmanager_policy_doc.json
}
