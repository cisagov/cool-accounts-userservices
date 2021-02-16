# ------------------------------------------------------------------------------
# Attach to the ProvisionDomainManager role the IAM policy that allows
# sufficient permissions to provision Domain Manager in the User Services
# account.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "provisiondomainmanager_policy_attachment" {
  policy_arn = aws_iam_policy.provisiondomainmanager_policy.arn
  role       = aws_iam_role.provisiondomainmanager_role.name
}
