provider "aws" {
  region  = "us-east-1"
}
module "config" {
    source = "github.com/GSA/grace-config?ref=v0.0.3"
    bucket = "gsa-tts-grace-config-logging"
    config_snapshot_frequency = "Six_Hours"
    iam_inactive_credentials_days = "120"
    access_key_expiration_days = "3"
}
