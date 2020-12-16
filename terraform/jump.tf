# set up cross account access on the jump account side

locals {
  role_name = "CrossAccountAdmin"
}

# allow assuming admin role into all accounts in the organization
data "aws_iam_policy_document" "cross_account" {
  statement {
    actions   = ["sts:AssumeRole"]
    resources = [for acct in data.aws_organizations_organization.main.accounts : "arn:aws:iam::${acct.id}:role/${local.role_name}"]
  }
}

resource "aws_iam_policy" "assume_role" {
  name   = "allow-assume-cross-account-role"
  policy = data.aws_iam_policy_document.cross_account.json
}

resource "aws_iam_group_policy_attachment" "assume_role" {
  group      = aws_iam_group.admins.name
  policy_arn = aws_iam_policy.assume_role.arn
}

# create local config file

data "aws_region" "current" {}

resource "local_file" "aws_config" {
  # https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html#cli-configure-files-settings
  # https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html
  content = <<EOT
[default]
region = ${data.aws_region.current.name}
%{for account in data.aws_organizations_organization.main.accounts}
[profile ${replace(lower(account.name), "/\\W/", "-")}]
role_arn = arn:aws:iam::${account.id}:role/${local.role_name}
source_profile = default
%{endfor~}
EOT

  filename        = "${path.module}/aws_config.ini"
  file_permission = "0600"
}
module "tts_jump_config" {
  source = "./config"
}