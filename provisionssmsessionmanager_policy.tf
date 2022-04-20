# ------------------------------------------------------------------------------
# Create the IAM policy that allows all of the permissions necessary
# to provision the SSM Document resource and set up SSM session
# logging in this account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisionssmsessionmanager_policy_doc" {
  # SSM document permissions
  statement {
    actions = [
      "ssm:AddTagsToResource",
      "ssm:CreateDocument",
      "ssm:DeleteDocument",
      "ssm:DescribeDocument*",
      "ssm:GetDocument",
      "ssm:UpdateDocument*",
    ]

    resources = [
      "arn:aws:ssm:${var.aws_region}:${local.userservices_account_id}:document/SSM-SessionManagerRunShell",
    ]
  }

  # CloudWatch log group permissions
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:DescribeLogGroups",
      "logs:ListTagsLogGroup",
    ]

    resources = [
      "*",
    ]
  }
  statement {
    actions = [
      "logs:DeleteLogGroup",
      "logs:PutRetentionPolicy",
      "logs:TagLogGroup",
    ]

    resources = [
      "arn:aws:logs:${var.aws_region}:${local.userservices_account_id}:log-group:${module.session_manager.ssm_session_log_group.name}:*",
    ]
  }
}

resource "aws_iam_policy" "provisionssmsessionmanager_policy" {
  description = var.provisionssmsessionmanager_policy_description
  name        = var.provisionssmsessionmanager_policy_name
  policy      = data.aws_iam_policy_document.provisionssmsessionmanager_policy_doc.json
}
