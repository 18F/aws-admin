module "cloud_gov" {
  source                  = "./business_unit"
  providers               = {
    aws                       = aws.payer
  }

  name                    = "cloud-gov"
  email                   = "support@cloud.gov"
}

module "cloud_gov_jump" {
  source                  = "./account"
  providers               = {
    aws                       = aws.payer
  }

  name                    = "tts-cloudgov-jump"
  org_unit_id             = module.cloud_gov.org_unit_id
}

module "cloud_gov_jump_setup" {
  source                  = "./account_setup"

  name                    = "tts-cloudgov-jump"
  account_id              = module.cloud_gov_jump.account_id
  cross_account_role_name = local.role_name
}

module "cloud_gov_sandbox" {
  source                  = "./account"
  providers               = {
    aws                       = aws.payer
  }

  name                    = "tts-cloudgov-sandbox"
  org_unit_id             = module.cloud_gov.org_unit_id
}

module "cloud_gov_sandbox_setup" {
  source                  = "./account_setup"

  name                    = "tts-cloudgov-sandbox"
  account_id              = module.cloud_gov_sandbox.account_id
  cross_account_role_name = local.role_name
}

module "federalist" {
  source                  = "./account"
  providers               = {
    aws                       = aws.payer
  }

  name                    = "federalist"
  org_unit_id             = module.cloud_gov.org_unit_id
}

module "federalist_setup" {
  source                  = "./account_setup"

  name                    = "federalist"
  account_id              = module.federalist.account_id
  cross_account_role_name = local.role_name
}

module "federalist_admin_1" {
  source                  = "./account"
  providers               = {
    aws                       = aws.payer
  }

  name                    = "federalist_admin_1"
  org_unit_id             = module.cloud_gov.org_unit_id
}

module "federalist_admin_1_setup" {
  source                  = "./account_setup"

  name                    = "federalist-admin-1"
  account_id              = module.federalist_admin_1.account_id
  cross_account_role_name = local.role_name
}

module "federalist_admin_2" {
  source                  = "./account"
  providers               = {
    aws                       = aws.payer
  }

  name                    = "federalist_admin_2"
  org_unit_id             = module.cloud_gov.org_unit_id
}

module "federalist_admin_2_setup" {
  source                  = "./account_setup"

  name                    = "federalist-admin-2"
  account_id              = module.federalist_admin_2.account_id
  cross_account_role_name = local.role_name
}
