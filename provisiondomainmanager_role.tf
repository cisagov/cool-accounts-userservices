# ------------------------------------------------------------------------------
# Create the IAM role that allows sufficient permissions to provision
# all AWS resources for Domain Manager in the User Services account.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "provisiondomainmanager_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.provisiondomainmanager_role_description
  name               = var.provisiondomainmanager_role_name
  tags               = var.tags
}
