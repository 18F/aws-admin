locals {
  u_18f_enterprise_account_id = "144433228153"
  tts_payer_account_id        = "810504390172"
}

module "tts_payer_setup" {
  source = "./account_setup"


  account_id              = local.u_18f_enterprise_account_id
  cross_account_role_name = local.role_name
}

module "u_18f_enterprise_setup" {
  source = "./account_setup"

  account_id              = local.tts_payer_account_id
  cross_account_role_name = local.role_name
}

resource "aws_s3_bucket" "backend" {
  bucket = "gsa-tts-grace-config"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  lifecycle {
    prevent_destroy = false
  }
  versioning {
    enabled = false
    mfa_delete = true
  }
  logging {
    target_bucket = "gsa-tts-grace-config"
    target_prefix = "tfstate/"
  }
  tags = {
    Project = "https://github.com/18F/aws-admin"
  }
}
module "config" {
    source = "github.com/GSA/grace-config?ref=v0.0.3"
    bucket = "gsa-tts-grace-config"
    config_snapshot_frequency = "Six_Hours"
    iam_password_policy_min_length = "16"
    iam_password_policy_max_age_days = "90"
    iam_inactive_credentials_days = "120"
    access_key_expiration_days = "3"
}