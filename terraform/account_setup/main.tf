provider "aws" {
  alias  = "child"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/${var.cross_account_role_name}"
  }
}

data "aws_caller_identity" "jump_account" {}

resource "aws_iam_group" "admins" {
  provider = aws.child

  name = "Administrators"
}

resource "aws_iam_group_policy_attachment" "admin" {
  provider = aws.child

  group      = aws_iam_group.admins.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role" "tts_securityaudit_role" {
  provider = aws.child
  name = "tts_securityaudit_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.jump_account.account_id}:root"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "tts_securityaudit_role" {
  provider = aws.child
  role       = aws_iam_role.tts_securityaudit_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

module "config" {
  providers = {
    aws = aws.child
  }

  source = "github.com/GSA/grace-config?ref=v0.0.3"
  bucket = "gsa-tts-grace-config-logging-${var.name}"
  config_snapshot_frequency = "TwentyFour_Hours"
  iam_inactive_credentials_days = "365"
  access_key_expiration_days = "365"
}

module "logging" {
  providers = {
    aws = aws.child
  }

  source                     = "github.com/GSA/grace-logging?ref=v0.0.11"
  access_logging_bucket_name = "gsa-tts-grace-config-access-${var.name}"
  cloudtrail_name            = "gsa-tts-wide"
  logging_bucket_name        = "gsa-tts-grace-config-logging-${var.name}"
}

module "alerting" {
  providers = {
    aws = aws.child
  }

  source                    = "github.com/GSA/grace-alerting?ref=v0.0.3"
  cloudtrail_log_group_name = "gsa-tts-wide"
  recipient                 = "18fsoftware@gsa.gov"
}
