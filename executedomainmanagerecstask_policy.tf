# ------------------------------------------------------------------------------
# Create the IAM policy that allows sufficient AWS permissions to execute
# Domain Manager ECS tasks in the User Services account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "executedomainmanagerecstask" {
  statement {
    actions = [
      "acm:DeleteCertificate",
      "acm:GetCertificate",
      "acm:ListTagsForCertificate",
      "acm:RemoveTagsFromCertificate",
      "acm:UpdateCertificateOptions",
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
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "cloudfront:DeleteDistribution",
      "cloudfront:GetDistribution",
      "cloudfront:GetDistributionConfig",
      "cloudfront:UntagResource",
      "cloudfront:UpdateDistribution"
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
      "cloudfront:CreateDistribution",
      "cloudfront:CreateDistributionWithTags",
      "cloudfront:ListDistributions",
      "cloudfront:ListTagsForResource",
      "cloudfront:TagResource",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "cognito-idp:AdminAddUserToGroup",
      "cognito-idp:AdminConfirmSignUp",
      "cognito-idp:AdminCreateUser",
      "cognito-idp:AdminDeleteUser",
      "cognito-idp:AdminDisableUser",
      "cognito-idp:AdminEnableUser",
      "cognito-idp:AdminGetUser",
      "cognito-idp:AdminInitiateAuth",
      "cognito-idp:AdminListDevices",
      "cognito-idp:AdminListGroupsForUser",
      "cognito-idp:AdminRemoveUserFromGroup",
      "cognito-idp:AdminResetUserPassword",
      "cognito-idp:ListUsers",
      "cognito-idp:ListUsersInGroup",
      "cognito-idp:SignUp",
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
      "route53:ChangeResourceRecordSets",
      "route53:ChangeTagsForResource",
      "route53:CreateHostedZone",
      "route53:DeleteHostedZone",
      "route53:GetHostedZone",
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResource"
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "s3:CreateBucket",
      "s3:DeleteBucket",
      "s3:DeleteBucketPolicy",
      "s3:DeleteBucketWebsite",
      "s3:DeleteObject",
      "s3:GetBucketWebsite",
      "s3:GetObject",
      "s3:ListAllMyBuckets",
      "s3:ListBucket",
      "s3:PutBucketPolicy",
      "s3:PutBucketPublicAccessBlock",
      "s3:PutBucketTagging",
      "s3:PutBucketWebsite",
      "s3:PutObject"
    ]

    resources = ["*"]
  }


  statement {
    actions = [
      "sqs:SendMessage"
    ]

    resources = [
      "arn:aws:sqs:*:${local.userservices_account_id}:domain-manager-*",
    ]
  }
}

resource "aws_iam_policy" "executedomainmanagerecstask" {
  description = var.executedomainmanagerecstask_role_description
  name        = var.executedomainmanagerecstask_role_name
  policy      = data.aws_iam_policy_document.executedomainmanagerecstask.json
}
