output "provisionaccount_role" {
  value       = module.provisionaccount.provisionaccount_role
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in the User Services account."
}

output "provisiondomainmanager_role" {
  value       = aws_iam_role.provisiondomainmanager_role
  description = "The IAM role that allows sufficient permissions to provision all AWS resources for Domain Manager in the User Services account."
}
