# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "users_account_id" {
  type        = string
  description = "The ID of the users account.  This account will be allowed to assume the role that allows sufficient permissions to provision all AWS resources in the User Services account."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_region" {
  type        = string
  description = "The AWS region where the non-global resources for the User Services account are to be provisioned (e.g. \"us-east-1\")."
  default     = "us-east-1"
}

variable "executedomainmanagerecs_role_description" {
  type        = string
  description = "The description to associate with the IAM policy and role that allows sufficient AWS permissions to execute Domain Manager ECS in the User Services account."
  default     = "Allows sufficient permissions needed for Domain Manager ECS execution in the User Services account."
}

variable "executedomainmanagerecs_role_name" {
  type        = string
  description = "The name to assign the IAM policy and role that allows sufficient AWS permissions to execute Domain Manager ECS in the User Services account."
  default     = "ExecuteDomainManagerECS"
}

variable "executedomainmanagerecstask_role_description" {
  type        = string
  description = "The description to associate with the IAM policy and role that allows sufficient AWS permissions to execute Domain Manager ECS tasks in the User Services account."
  default     = "Allows sufficient permissions needed for Domain Manager ECS task execution in the User Services account."
}

variable "executedomainmanagerecstask_role_name" {
  type        = string
  description = "The name to assign the IAM policy and role that allows sufficient AWS permissions to execute Domain Manager ECS tasks in the User Services account."
  default     = "ExecuteDomainManagerECSTask"
}

variable "executedomainmanagerlambda_role_description" {
  type        = string
  description = "The description to associate with the IAM policy and role that allows sufficient AWS permissions to execute Domain Manager Lambdas in the User Services account."
  default     = "Allows sufficient permissions needed for Domain Manager Lambda execution in the User Services account."
}

variable "executedomainmanagerlambda_role_name" {
  type        = string
  description = "The name to assign the IAM policy and role that allows sufficient AWS permissions to execute Domain Manager Lambdas in the User Services account."
  default     = "ExecuteDomainManagerLambda"
}

variable "provisionaccount_role_description" {
  type        = string
  description = "The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the User Services account."
  default     = "Allows sufficient permissions to provision all AWS resources in the User Services account."
}

variable "provisionaccount_role_name" {
  type        = string
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the User Services account."
  default     = "ProvisionAccount"
}

variable "provisiondomainmanager_role_description" {
  type        = string
  description = "The description to associate with the IAM policy and role that allows sufficient permissions to provision all AWS resources needed for Domain Manager in the User Services account."
  default     = "Allows sufficient permissions to provision all AWS resources needed for Domain Manager in the User Services account."
}

variable "provisiondomainmanager_role_name" {
  type        = string
  description = "The name to assign the IAM policy and role that allows sufficient permissions to provision all AWS resources needed for Domain Manager in the User Services account."
  default     = "ProvisionDomainManager"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources provisioned."
  default     = {}
}
