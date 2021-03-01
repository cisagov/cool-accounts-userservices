output "executedomainmanagerecs_role" {
  value       = aws_iam_role.executedomainmanagerecs
  description = "The IAM role that allows sufficient permissions to execute Domain Manager ECS in the User Services account."
}

output "executedomainmanagerecstask_role" {
  value       = aws_iam_role.executedomainmanagerecstask
  description = "The IAM role that allows sufficient permissions to execute Domain Manager ECS tasks in the User Services account."
}

output "executedomainmanagerlambda_role" {
  value       = aws_iam_role.executedomainmanagerlambda
  description = "The IAM role that allows sufficient permissions to execute Domain Manager Lambdas in the User Services account."
}

output "provisionaccount_role" {
  value       = module.provisionaccount.provisionaccount_role
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in the User Services account."
}

output "provisiondomainmanager_role" {
  value       = aws_iam_role.provisiondomainmanager_role
  description = "The IAM role that allows sufficient permissions to provision all AWS resources for Domain Manager in the User Services account."
}
