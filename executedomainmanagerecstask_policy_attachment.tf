# ------------------------------------------------------------------------------
# Attach the policy that allows sufficient AWS permissions to execute Domain
# Manager ECS tasks in the User Services account to the appropriate role.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "executedomainmanagerecstask" {
  policy_arn = aws_iam_policy.executedomainmanagerecstask.arn
  role       = aws_iam_role.executedomainmanagerecstask.name
}
