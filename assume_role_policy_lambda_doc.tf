# ------------------------------------------------------------------------------
# Create an IAM policy document that allows Lambdas to assume this role.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "assume_role_lambda" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
      ]
    }
  }
}
