output "cw_alarm_sns_topic" {
  value       = module.cw_alarm_sns.sns_topic
  description = "The SNS topic to which a message is sent when a CloudWatch alarm is triggered."
}

output "provisionaccount_role" {
  value       = module.provisionaccount.provisionaccount_role
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in the User Services account."
}
