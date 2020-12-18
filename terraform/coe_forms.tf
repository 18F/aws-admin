module "tts_faas_dev" {
  source = "./account"
  providers = {
    aws = aws.payer
  }

  name        = "tts-faas-dev"
  org_unit_id = module.coe.org_unit_id
}

module "tts_faas_dev_setup" {
  source = "./account_setup"

  name        = "tts-faas-dev"
  account_id              = module.tts_faas_dev.account_id
  cross_account_role_name = local.role_name
}

module "tts_faas_test" {
  source = "./account"
  providers = {
    aws = aws.payer
  }

  name        = "tts-faas-test"
  org_unit_id = module.coe.org_unit_id
}

module "tts_faas_test_setup" {
  source = "./account_setup"

  name        = "tts-faas-test"
  account_id              = module.tts_faas_test.account_id
  cross_account_role_name = local.role_name
}

module "tts_faas_prod" {
  source = "./account"
  providers = {
    aws = aws.payer
  }

  name        = "tts-faas-prod"
  org_unit_id = module.coe.org_unit_id
}

module "tts_faas_prod_setup" {
  source = "./account_setup"

  name        = "tts-faas-prod"
  account_id              = module.tts_faas_prod.account_id
  cross_account_role_name = local.role_name
}
