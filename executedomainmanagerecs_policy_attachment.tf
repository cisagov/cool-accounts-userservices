# ------------------------------------------------------------------------------
# Attach the policies that allow sufficient AWS permissions to execute Domain
# Manager ECS in the User Services account to the appropriate role.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "executedomainmanagerecs" {
  policy_arn = aws_iam_policy.executedomainmanagerecs.arn
  role       = aws_iam_role.executedomainmanagerecs.name
}

resource "aws_iam_role_policy_attachment" "aws_ecs_task_execution_role" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.executedomainmanagerecs.name
}
