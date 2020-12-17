provider "aws" {
  region  = "us-east-1"
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

module "alerting" {
    source                    = "github.com/GSA/grace-alerting?ref=v0.0.3"
    cloudtrail_log_group_name = "gsa-tts-wide"
    recipient                 = "18fsoftware@gsa.gov"
}
