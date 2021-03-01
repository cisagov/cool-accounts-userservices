# ------------------------------------------------------------------------------
# Create the IAM role that allows sufficient AWS permissions to execute
# Domain Manager ECS tasks in the User Services account.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "executedomainmanagerecstask" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_ecs.json
  description        = var.executedomainmanagerecstask_role_description
  name               = var.executedomainmanagerecstask_role_name
  tags               = var.tags
}
