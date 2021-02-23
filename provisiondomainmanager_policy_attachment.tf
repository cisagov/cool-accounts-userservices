# ------------------------------------------------------------------------------
# Attach to the ProvisionDomainManager role the IAM policies that allow
# sufficient permissions to provision Domain Manager in the User Services
# account.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "provisiondomainmanager_policy_attachment_acm_cognito_ec2" {
  policy_arn = aws_iam_policy.provisiondomainmanager_policy_acm_cognito_ec2.arn
  role       = aws_iam_role.provisiondomainmanager_role.name
}

resource "aws_iam_role_policy_attachment" "provisiondomainmanager_policy_attachment_ecs_elb_events" {
  policy_arn = aws_iam_policy.provisiondomainmanager_policy_ecs_elb_events.arn
  role       = aws_iam_role.provisiondomainmanager_role.name
}

resource "aws_iam_role_policy_attachment" "provisiondomainmanager_policy_attachment_lambda_logs_rds" {
  policy_arn = aws_iam_policy.provisiondomainmanager_policy_lambda_logs_rds.arn
  role       = aws_iam_role.provisiondomainmanager_role.name
}

resource "aws_iam_role_policy_attachment" "provisiondomainmanager_policy_attachment_s3_sqs_ssm" {
  policy_arn = aws_iam_policy.provisiondomainmanager_policy_s3_sqs_ssm.arn
  role       = aws_iam_role.provisiondomainmanager_role.name
}
