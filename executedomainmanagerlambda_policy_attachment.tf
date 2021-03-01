# ------------------------------------------------------------------------------
# Attach the policy that allows sufficient AWS permissions to execute Domain
# Manager Lambdas in the User Services account to the appropriate role.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "executedomainmanagerlambda" {
  policy_arn = aws_iam_policy.executedomainmanagerlambda.arn
  role       = aws_iam_role.executedomainmanagerlambda.name
}
