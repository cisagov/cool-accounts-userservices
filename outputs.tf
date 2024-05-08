output "cw_alarm_sns_topic" {
  description = "The SNS topic to which a message is sent when a CloudWatch alarm is triggered."
  value       = module.cw_alarm_sns.sns_topic
}

output "provisionaccount_role" {
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in the User Services account."
  value       = module.provisionaccount.provisionaccount_role
}

output "ssm_session_role" {
  description = "An IAM role that allows creation of SSM SessionManager sessions to any EC2 instance in this account."
  value       = module.session_manager.ssm_session_role
}
