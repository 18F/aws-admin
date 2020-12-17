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

module "logging" {
  source                     = "github.com/GSA/grace-logging?ref=v0.0.11"
  access_logging_bucket_name = "gsa-tts-grace-config-access"
  cloudtrail_name            = "gsa-tts-wide"
  logging_bucket_name        = "gsa-tts-grace-config-logging"
}

module "alerting" {
    source                    = "github.com/GSA/grace-alerting?ref=v0.0.3"
    cloudtrail_log_group_name = "gsa-tts-wide"
    recipient                 = "18fsoftware@gsa.gov"
}
