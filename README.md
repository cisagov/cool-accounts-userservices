# cool-accounts-userservices #

[![GitHub Build Status](https://github.com/cisagov/cool-accounts-userservices/workflows/build/badge.svg)](https://github.com/cisagov/cool-accounts-userservices/actions)

This project contains Terraform code to perform the initial configuration
of a COOL User Services account. This Terraform code creates and configures
the most basic resources needed to build out services and environments.

It creates an IAM role that allows sufficient permissions to provision all
AWS resources in this account. This role has a trust relationship with the
COOL users account.

## Bootstrapping this account ##

Note that the COOL User Services account must be bootstrapped. This is because
initially there is no IAM role that can be assumed to build out these
resources. Therefore you must first apply the Terraform code using
programmatic credentials for AWSAdministratorAccess as obtained for the
COOL User Services account from the COOL AWS SSO page.

After this initial apply your desired IAM role will exist, and it will
be assumable from your IAM user that exists in the COOL users
account. Therefore you can apply future changes using your IAM user
credentials.

To do this bootstrapping, follow these steps:

1. Comment out the `profile = "cool-userservices-provisionaccount"`
   line for the "default" provider in `providers.tf` and directly
   below that uncomment the line `profile = "cool-userservices-account-admin"`.
1. Create a new AWS profile called `cool-userservices-account-admin`
   in your local configuration using the "AWSAdministratorAccess"
   credentials (access key ID, secret access key, and session token)
   as obtained from the COOL User Services account:

   ```ini
   [cool-userservices-account-admin]
   aws_access_key_id = <MY_ACCESS_KEY_ID>
   aws_secret_access_key = <MY_SECRET_ACCESS_KEY>
   aws_session_token = <MY_SESSION_TOKEN>
   ```

1. Create a Terraform workspace (if you haven't already done so) by running
   `terraform workspace new <workspace_name>`
1. Create a `<workspace_name>.tfvars` file with all of the required
   variables (see [Inputs](#Inputs) below for details):

   ```hcl
   users_account_id = "222222222222"
   ```

1. Run the command `terraform init`.
1. Run the command `terraform apply
   -var-file=<workspace_name>.tfvars`.
1. Revert the changes you made to `providers.tf` in step 1.
1. Create a new AWS profile called `cool-userservices-provisionaccount`
   in your local configuration that includes the `provisionaccount_role` ARN
   output from the previous step, for example:

   ```ini
   [cool-userservices-provisionaccount]
   role_arn = arn:aws:iam::111111111111:role/ProvisionAccount
   role_session_name = your.session.name
   source_profile = cool-user-base-profile
   ```

1. Run the command `terraform apply
    -var-file=<workspace_name>.tfvars`.

At this point the account has been bootstrapped, and you can apply
future changes by simply running `terraform apply
-var-file=<workspace_name>.tfvars`.

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 3.38 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.38 |

## Modules ##

| Name | Source | Version |
|------|--------|---------|
| provisionaccount | github.com/cisagov/provisionaccount-role-tf-module | n/a |

## Resources ##

| Name | Type |
|------|------|
| [aws_caller_identity.userservices](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The AWS region where the non-global resources for the User Services account are to be provisioned (e.g. "us-east-1"). | `string` | `"us-east-1"` | no |
| provisionaccount\_role\_description | The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the User Services account. | `string` | `"Allows sufficient permissions to provision all AWS resources in the User Services account."` | no |
| provisionaccount\_role\_name | The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the User Services account. | `string` | `"ProvisionAccount"` | no |
| tags | Tags to apply to all AWS resources provisioned. | `map(string)` | `{}` | no |
| users\_account\_id | The ID of the users account.  This account will be allowed to assume the role that allows sufficient permissions to provision all AWS resources in the User Services account. | `string` | n/a | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| provisionaccount\_role | The IAM role that allows sufficient permissions to provision all AWS resources in the User Services account. |

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, this is just the main directory.

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
