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
