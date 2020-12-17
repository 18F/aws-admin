resource "aws_organizations_account" "account" {
  name                       = var.name
  email                      = "devops+aws-${replace(var.name, "tts-", "")}@gsa.gov"
  iam_user_access_to_billing = "ALLOW"
  parent_id                  = var.org_unit_id

  lifecycle {
    ignore_changes  = [email, role_name]
    prevent_destroy = true
  }
}

module "config" {
  source = "github.com/GSA/grace-config?ref=v0.0.3"
  bucket = "gsa-tts-grace-config-logging-${var.name}"
  config_snapshot_frequency = "TwentyFour_Hours"
  iam_inactive_credentials_days = "365"
  access_key_expiration_days = "365"
}

module "logging" {
  source                     = "github.com/GSA/grace-logging?ref=v0.0.11"
  access_logging_bucket_name = "gsa-tts-grace-config-access-${var.name}"
  cloudtrail_name            = "gsa-tts-wide"
  logging_bucket_name        = "gsa-tts-grace-config-logging-${var.name}"
}

module "alerting" {
  source                    = "github.com/GSA/grace-alerting?ref=v0.0.3"
  cloudtrail_log_group_name = "gsa-tts-wide"
  recipient                 = "18fsoftware@gsa.gov"
}
