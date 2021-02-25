# ------------------------------------------------------------------------------
# Create the IAM policies that allow sufficient permissions to provision
# all AWS resources for Domain Manager in the User Services account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisiondomainmanager_policy_acm_cognito_ec2_doc" {
  statement {
    actions = [
      "acm:DeleteCertificate",
      "acm:GetCertificate",
      "acm:ListTagsForCertificate",
      "acm:RemoveTagsFromCertificate",
      "acm:UpdateCertificateOptions",
      "cognito-idp:AdminAddUserToGroup",
      "cognito-idp:AdminConfirmSignUp",
      "cognito-idp:AdminCreateUser",
      "cognito-idp:AdminDeleteUser",
      "cognito-idp:AdminDisableUser",
      "cognito-idp:AdminEnableUser",
      "cognito-idp:AdminGetUser",
      "cognito-idp:AdminListDevices",
      "cognito-idp:AdminListGroupsForUser",
      "cognito-idp:AdminRemoveUserFromGroup",
      "cognito-idp:AdminResetUserPassword",
      "cognito-idp:ConfirmSignUp",
      "cognito-idp:CreateGroup",
      "cognito-idp:CreateUserPoolClient",
      "cognito-idp:CreateUserPoolDomain",
      "cognito-idp:DeleteGroup",
      "cognito-idp:DeleteUser",
      "cognito-idp:DeleteUserPool",
      "cognito-idp:DeleteUserPoolClient",
      "cognito-idp:DeleteUserPoolDomain",
      "cognito-idp:GetGroup",
      "cognito-idp:GetUser",
      "cognito-idp:GetUserPoolMfaConfig",
      "cognito-idp:ListGroups",
      "cognito-idp:ListUserPoolClients",
      "cognito-idp:ListUsers",
      "cognito-idp:ListUsersInGroup",
      "cognito-idp:SetUserPoolMfaConfig",
      "cognito-idp:SignUp",
      "cognito-idp:UpdateGroup",
      "cognito-idp:UpdateUserPool",
      "cognito-idp:UpdateUserPoolClient",
      "cognito-idp:UpdateUserPoolDomain",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteTags",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
      "ec2:UpdateSecurityGroupRuleDescriptionsIngress",
    ]

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/app"
      values   = ["domain-manager"]
    }
  }

  statement {
    actions = [
      "acm:AddTagsToCertificate",
      "acm:DescribeCertificate",
      "acm:ListCertificates",
      "acm:RequestCertificate",
      "cognito-idp:CreateUserPool",
      "cognito-idp:DescribeUserPool",
      "cognito-idp:DescribeUserPoolClient",
      "cognito-idp:DescribeUserPoolDomain",
      "cognito-idp:ListUserPools",
      "cognito-idp:TagResource",
      "ec2:CreateNetworkInterface",
      "ec2:CreateSecurityGroup",
      "ec2:CreateTags",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "ec2:DescribeVpcs",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "provisiondomainmanager_policy_acm_cognito_ec2" {
  description = "${var.provisiondomainmanager_role_description} (ACM, Cognito, EC2)"
  name        = "${var.provisiondomainmanager_role_name}-acm-cognito-ec2"
  policy      = data.aws_iam_policy_document.provisiondomainmanager_policy_acm_cognito_ec2_doc.json
}

data "aws_iam_policy_document" "provisiondomainmanager_policy_ecr_ecs_elb_events_doc" {
  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchDeleteImage",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:CreateRepository",
      "ecr:DeleteLifecyclePolicy",
      "ecr:DeleteRepository",
      "ecr:DeleteRepositoryPolicy",
      "ecr:DescribeImages",
      "ecr:GetLifecyclePolicy",
      "ecr:GetRepositoryPolicy",
      "ecr:InitiateLayerUpload",
      "ecr:ListImages",
      "ecr:PutImage",
      "ecr:PutLifecyclePolicy",
      "ecr:SetRepositoryPolicy",
      "ecr:UploadLayerPart",
    ]

    resources = [
      "arn:aws:ecr::${local.userservices_account_id}:repository/domain-manager-*",
    ]
  }

  statement {
    actions = [
      "ecr:DescribeRegistry",
      "ecr:DescribeRepositories",
      "ecr:GetAuthorizationToken",
      "ecr:ListTagsForResource",
      "ecr:TagResource",
      "ecr:UntagResource",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "ecs:CreateService",
      "ecs:DeleteCluster",
      "ecs:DeleteService",
      "ecs:DeregisterContainerInstance",
      "ecs:ListContainerInstances",
      "ecs:ListServices",
      "ecs:ListTaskDefinitionFamilies",
      "ecs:ListTaskDefinitions",
      "ecs:ListTasks",
      "ecs:RegisterContainerInstance",
      "ecs:RunTask",
      "ecs:StartTask",
      "ecs:StopTask",
      "ecs:SubmitContainerStateChange",
      "ecs:UpdateContainerAgent",
      "ecs:UpdateContainerInstancesState",
      "ecs:UpdateService",
      "ecs:UpdateServicePrimaryTaskSet",
    ]

    resources = [
      "arn:aws:ecs::${local.userservices_account_id}:cluster/domain-manager-*",
      "arn:aws:ecs::${local.userservices_account_id}:service/domain-manager-*",
      "arn:aws:ecs::${local.userservices_account_id}:task/domain-manager-*",
      "arn:aws:ecs::${local.userservices_account_id}:task-definition/domain-manager-*",
    ]
  }

  statement {
    actions = [
      "elasticloadbalancing:AddListenerCertificates",
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:CreateListener",
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateRule",
      "elasticloadbalancing:CreateTargetGroup",
      "elasticloadbalancing:DeleteListener",
      "elasticloadbalancing:DeleteLoadBalancer",
      "elasticloadbalancing:DeleteRule",
      "elasticloadbalancing:DeleteTargetGroup",
      "elasticloadbalancing:DeregisterTargets",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:ModifyRule",
      "elasticloadbalancing:ModifyTargetGroup",
      "elasticloadbalancing:ModifyTargetGroupAttributes",
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:RemoveListenerCertificates",
      "elasticloadbalancing:RemoveTags",
      "elasticloadbalancing:RemoveTags",
      "elasticloadbalancing:SetIpAddressType",
      "elasticloadbalancing:SetRulePriorities",
      "elasticloadbalancing:SetSecurityGroups",
      "elasticloadbalancing:SetSubnets",
      "elasticloadbalancing:SetWebAcl",
    ]

    resources = [
      "arn:aws:elasticloadbalancing::${local.userservices_account_id}:listener/*/domain-manager-*",
      "arn:aws:elasticloadbalancing::${local.userservices_account_id}:listener-rule/*/domain-manager-*",
      "arn:aws:elasticloadbalancing::${local.userservices_account_id}:loadbalancer/*/domain-manager-*",
      "arn:aws:elasticloadbalancing::${local.userservices_account_id}:targetgroup/domain-manager-*",
    ]
  }

  statement {
    actions = [
      "events:DeleteRule",
      "events:DescribeRule",
      "events:DisableRule",
      "events:EnableRule",
      "events:ListRuleNamesByTarget",
      "events:ListRules",
      "events:ListTagsForResource",
      "events:ListTargetsByRule",
      "events:PutEvents",
      "events:PutPermission",
      "events:PutRule",
      "events:PutTargets",
      "events:RemovePermission",
      "events:RemoveTargets",
      "events:TagResource",
      "events:UntagResource",
    ]

    resources = [
      "arn:aws:events::${local.userservices_account_id}:rule/domain-manager-*",
    ]
  }

  statement {
    actions = [
      "ecs:CreateCluster",
      "ecs:DeregisterTaskDefinition",
      "ecs:DescribeClusters",
      "ecs:DescribeContainerInstances",
      "ecs:DescribeServices",
      "ecs:DescribeTaskDefinition",
      "ecs:DescribeTasks",
      "ecs:ListClusters",
      "ecs:RegisterTaskDefinition",
      "elasticloadbalancing:DescribeListenerCertificates",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeRules",
      "elasticloadbalancing:DescribeSSLPolicies",
      "elasticloadbalancing:DescribeTags",
      "elasticloadbalancing:DescribeTargetGroupAttributes",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetHealth",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "provisiondomainmanager_policy_ecr_ecs_elb_events" {
  description = "${var.provisiondomainmanager_role_description} (ECR, ECS, ELB, Events)"
  name        = "${var.provisiondomainmanager_role_name}-ecr-ecs-elb-events"
  policy      = data.aws_iam_policy_document.provisiondomainmanager_policy_ecr_ecs_elb_events_doc.json
}

data "aws_iam_policy_document" "provisiondomainmanager_policy_lambda_logs_rds_doc" {
  statement {
    actions = [
      "lambda:AddLayerVersionPermission",
      "lambda:AddPermission",
      "lambda:CreateCodeSigningConfig",
      "lambda:CreateFunction",
      "lambda:DeleteCodeSigningConfig",
      "lambda:DeleteFunction",
      "lambda:DeleteFunctionCodeSigningConfig",
      "lambda:DeleteFunctionConcurrency",
      "lambda:DeleteFunctionEventInvokeConfig",
      "lambda:DeleteLayerVersion",
      "lambda:DeleteProvisionedConcurrencyConfig",
      "lambda:GetCodeSigningConfig",
      "lambda:GetFunction",
      "lambda:GetFunctionCodeSigningConfig",
      "lambda:GetFunctionConcurrency",
      "lambda:GetFunctionConfiguration",
      "lambda:GetFunctionEventInvokeConfig",
      "lambda:GetLayerVersion",
      "lambda:GetLayerVersionPolicy",
      "lambda:GetLayerVersionPolicy",
      "lambda:GetPolicy",
      "lambda:GetProvisionedConcurrencyConfig",
      "lambda:InvokeFunction",
      "lambda:ListCodeSigningConfigs",
      "lambda:ListFunctionEventInvokeConfigs",
      "lambda:ListFunctionsByCodeSigningConfig",
      "lambda:ListLayerVersions",
      "lambda:ListProvisionedConcurrencyConfigs",
      "lambda:ListVersionsByFunction",
      "lambda:PublishLayerVersion",
      "lambda:PutFunctionCodeSigningConfig",
      "lambda:PutFunctionConcurrency",
      "lambda:PutFunctionEventInvokeConfig",
      "lambda:PutProvisionedConcurrencyConfig",
      "lambda:RemoveLayerVersionPermission",
      "lambda:RemovePermission",
      "lambda:UpdateCodeSigningConfig",
      "lambda:UpdateFunctionCode",
      "lambda:UpdateFunctionCodeSigningConfig",
      "lambda:UpdateFunctionConfiguration",
      "lambda:UpdateFunctionEventInvokeConfig",
    ]

    resources = [
      "arn:aws:lambda::${local.userservices_account_id}:layer:domain-manager-*",
      "arn:aws:lambda::${local.userservices_account_id}:function:domain-manager-*",
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DeleteLogGroup",
      "logs:DeleteLogStream",
      "logs:DeleteMetricFilter",
      "logs:DeleteResourcePolicy",
      "logs:DeleteRetentionPolicy",
      "logs:DescribeLogStreams",
      "logs:DescribeMetricFilters",
      "logs:DescribeResourcePolicies",
      "logs:FilterLogEvents",
      "logs:GetLogEvents",
      "logs:GetLogGroupFields",
      "logs:GetLogRecord",
      "logs:ListTagsLogGroup",
      "logs:PutLogEvents",
      "logs:PutMetricFilter",
      "logs:PutResourcePolicy",
      "logs:PutRetentionPolicy",
      "logs:TagLogGroup",
      "logs:UntagLogGroup",
    ]

    resources = [
      "arn:aws:logs::${local.userservices_account_id}:log-group:domain-manager-*:*",
    ]
  }

  statement {
    actions = [
      "rds:AddTagsToResource",
      "rds:AuthorizeDBSecurityGroupIngress",
      "rds:CopyDBClusterSnapshot",
      "rds:CopyDBParameterGroup",
      "rds:CopyDBSnapshot",
      "rds:CopyOptionGroup",
      "rds:CreateDBCluster",
      "rds:CreateDBClusterEndpoint",
      "rds:CreateDBClusterParameterGroup",
      "rds:CreateDBClusterSnapshot",
      "rds:CreateDBInstance",
      "rds:CreateDBParameterGroup",
      "rds:CreateDBSecurityGroup",
      "rds:CreateDBSnapshot",
      "rds:CreateDBSubnetGroup",
      "rds:CreateEventSubscription",
      "rds:CreateOptionGroup",
      "rds:DeleteDBCluster",
      "rds:DeleteDBClusterEndpoint",
      "rds:DeleteDBClusterParameterGroup",
      "rds:DeleteDBClusterSnapshot",
      "rds:DeleteDBInstance",
      "rds:DeleteDBInstanceAutomatedBackup",
      "rds:DeleteDBParameterGroup",
      "rds:DeleteDBSecurityGroup",
      "rds:DeleteDBSnapshot",
      "rds:DeleteDBSubnetGroup",
      "rds:DeleteEventSubscription",
      "rds:DeleteOptionGroup",
      "rds:DescribeDBClusterEndpoints",
      "rds:DescribeDBClusterParameterGroups",
      "rds:DescribeDBClusterParameters",
      "rds:DescribeDBClusterSnapshotAttributes",
      "rds:DescribeDBClusterSnapshots",
      "rds:DescribeDBClusters",
      "rds:DescribeDBInstanceAutomatedBackups",
      "rds:DescribeDBInstances",
      "rds:DescribeDBParameterGroups",
      "rds:DescribeDBParameters",
      "rds:DescribeDBSecurityGroups",
      "rds:DescribeDBSnapshotAttributes",
      "rds:DescribeDBSnapshots",
      "rds:DescribeDBSubnetGroups",
      "rds:DescribeEngineDefaultClusterParameters",
      "rds:DescribeEngineDefaultParameters",
      "rds:DescribeEventCategories",
      "rds:DescribeEventSubscriptions",
      "rds:DescribeEvents",
      "rds:DescribeOptionGroupOptions",
      "rds:DescribeOptionGroups",
      "rds:ListTagsForResource",
      "rds:ModifyDBCluster",
      "rds:ModifyDBClusterEndpoint",
      "rds:ModifyDBClusterParameterGroup",
      "rds:ModifyDBClusterSnapshotAttribute",
      "rds:ModifyDBInstance",
      "rds:ModifyDBParameterGroup",
      "rds:ModifyDBSnapshot",
      "rds:ModifyDBSnapshotAttribute",
      "rds:ModifyDBSubnetGroup",
      "rds:ModifyEventSubscription",
      "rds:ModifyOptionGroup",
      "rds:RebootDBInstance",
      "rds:RemoveTagsFromResource",
      "rds:ResetDBClusterParameterGroup",
      "rds:ResetDBParameterGroup",
      "rds:RestoreDBClusterFromS3",
      "rds:RestoreDBClusterFromSnapshot",
      "rds:RestoreDBClusterToPointInTime",
      "rds:RestoreDBInstanceFromDBSnapshot",
      "rds:RestoreDBInstanceFromS3",
      "rds:RestoreDBInstanceToPointInTime",
      "rds:RevokeDBSecurityGroupIngress",
      "rds:StartDBCluster",
      "rds:StartDBInstance",
      "rds:StopDBCluster",
      "rds:StopDBInstance",
    ]

    resources = [
      "arn:aws:rds::${local.userservices_account_id}:cluster:domain-manager-*",
      "arn:aws:rds::${local.userservices_account_id}:cluster-pg:domain-manager-*",
      "arn:aws:rds::${local.userservices_account_id}:cluster-snapshot:domain-manager-*",
      "arn:aws:rds::${local.userservices_account_id}:db:domain-manager-*",
      "arn:aws:rds::${local.userservices_account_id}:secgrp:domain-manager-*",
      "arn:aws:rds::${local.userservices_account_id}:subgrp:domain-manager-*",
    ]
  }

  statement {
    actions = [
      "lambda:CreateEventSourceMapping",
      "lambda:DeleteEventSourceMapping",
      "lambda:GetEventSourceMapping",
      "lambda:ListEventSourceMappings",
      "lambda:ListFunctions",
      "lambda:ListLayers",
      "lambda:UpdateEventSourceMapping",
      "logs:DescribeLogGroups",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "provisiondomainmanager_policy_lambda_logs_rds" {
  description = "${var.provisiondomainmanager_role_description} (Lambda, Logs, RDS)"
  name        = "${var.provisiondomainmanager_role_name}-lambda-logs-rds"
  policy      = data.aws_iam_policy_document.provisiondomainmanager_policy_lambda_logs_rds_doc.json
}

data "aws_iam_policy_document" "provisiondomainmanager_policy_s3_sqs_ssm_doc" {
  statement {
    actions = [
      "s3:CreateBucket",
      "s3:DeleteBucket",
      "s3:DeleteBucketPolicy",
      "s3:DeleteBucketWebsite",
      "s3:DeleteObject",
      "s3:GetAccelerateConfiguration",
      "s3:GetBucketAcl",
      "s3:GetBucketCORS",
      "s3:GetBucketLocation",
      "s3:GetBucketLogging",
      "s3:GetBucketNotification",
      "s3:GetBucketObjectLockConfiguration",
      "s3:GetBucketPolicy",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetBucketRequestPayment",
      "s3:GetBucketTagging",
      "s3:GetBucketVersioning",
      "s3:GetBucketWebsite",
      "s3:GetEncryptionConfiguration",
      "s3:GetLifecycleConfiguration",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetReplicationConfiguration",
      "s3:ListAllMyBuckets",
      "s3:ListBucket",
      "s3:ListBucketVersions",
      "s3:PutAccelerateConfiguration",
      "s3:PutBucketAcl",
      "s3:PutBucketCORS",
      "s3:PutBucketLogging",
      "s3:PutBucketNotification",
      "s3:PutBucketObjectLockConfiguration",
      "s3:PutBucketPolicy",
      "s3:PutBucketPublicAccessBlock",
      "s3:PutBucketRequestPayment",
      "s3:PutBucketTagging",
      "s3:PutBucketVersioning",
      "s3:PutBucketWebsite",
      "s3:PutEncryptionConfiguration",
      "s3:PutLifecycleConfiguration",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:PutReplicationConfiguration",
      "s3:ReplicateObject",
      "s3:RestoreObject",
    ]

    resources = [
      "arn:aws:s3:::domain-manager-*",
    ]
  }

  statement {
    actions = [
      "sqs:AddPermission",
      "sqs:CreateQueue",
      "sqs:DeleteMessage",
      "sqs:DeleteQueue",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ListDeadLetterSourceQueues",
      "sqs:ListQueueTags",
      "sqs:ListQueues",
      "sqs:PurgeQueue",
      "sqs:ReceiveMessage",
      "sqs:RemovePermission",
      "sqs:SetQueueAttributes",
      "sqs:TagQueue",
      "sqs:UntagQueue",
    ]

    resources = [
      "arn:aws:sqs::${local.userservices_account_id}:domain-manager-*",
    ]
  }

  statement {
    actions = [
      "ssm:AddTagsToResource",
      "ssm:DeleteParameter",
      "ssm:DeleteParameters",
      "ssm:DescribeDocumentParameters",
      "ssm:GetParameter",
      "ssm:GetParameterHistory",
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
      "ssm:LabelParameterVersion",
      "ssm:ListTagsForResource",
      "ssm:PutParameter",
      "ssm:RemoveTagsFromResource",
    ]

    resources = [
      "arn:aws:ssm::${local.userservices_account_id}:parameter/domain-manager/*",
    ]
  }

  statement {
    actions = [
      "ssm:DescribeParameters",
      "sts:GetCallerIdentity",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "provisiondomainmanager_policy_s3_sqs_ssm" {
  description = "${var.provisiondomainmanager_role_description} (S3, SQS, SSM)"
  name        = "${var.provisiondomainmanager_role_name}-s3-sqs-ssm"
  policy      = data.aws_iam_policy_document.provisiondomainmanager_policy_s3_sqs_ssm_doc.json
}
