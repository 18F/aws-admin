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