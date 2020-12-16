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

module "logging" {
  source                     = "github.com/GSA/grace-logging?ref=v0.0.11"
  access_logging_bucket_name = "gsa-tts-grace-config-access"
  cloudtrail_name            = "gsa-tts-wide"
  logging_bucket_name        = "gsa-tts-grace-config-logging"
}
module "config" {
    source = "github.com/GSA/grace-config?ref=v0.0.3"
    bucket = "gsa-tts-grace-config-logging"
    config_snapshot_frequency = "Six_Hours"
    iam_inactive_credentials_days = "120"
    access_key_expiration_days = "3"
}