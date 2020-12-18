locals {
  pif_gov_account_id = "541873662368"
}

module "pif_gov_setup" {
  source = "./account_setup"

  name                    = "pif-gov"
  account_id              = local.pif_gov_account_id
  cross_account_role_name = local.role_name
}
