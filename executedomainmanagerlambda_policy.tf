# ------------------------------------------------------------------------------
# Create the IAM policy that allows sufficient AWS permissions to execute
# Domain Manager Lambdas in the User Services account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "executedomainmanagerlambda" {
  statement {
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
    ]

    resources = [
      "arn:aws:logs:::*",
    ]
  }

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:::log-group:/aws/lambda/*:*",
    ]
  }

  statement {
    actions = [
      "sqs:SendMessage",
    ]

    resources = [
      "arn:aws:sqs:*:${local.userservices_account_id}:domain-manager-*",
    ]
  }
}

resource "aws_iam_policy" "executedomainmanagerlambda" {
  description = var.executedomainmanagerlambda_role_description
  name        = var.executedomainmanagerlambda_role_name
  policy      = data.aws_iam_policy_document.executedomainmanagerlambda.json
}
