module "login_gov" {
  source = "./business_unit"
  providers = {
    aws = aws.payer
  }

  name  = "login-gov"
  email = "security-team@login.gov"
}

module "login_gov_alpha" {
  source = "./account"
  providers = {
    aws = aws.payer
  }

  name        = "login-alpha"
  org_unit_id = module.login_gov.org_unit_id
}

module "login_gov_identity_give_test" {
  source = "./account"
  providers = {
    aws = aws.payer
  }

  name        = "identity-give-test"
  org_unit_id = module.login_gov.org_unit_id
}

module "login_gov_identity_give_dev" {
  source = "./account"
  providers = {
    aws = aws.payer
  }

  name        = "identity-give-dev"
  org_unit_id = module.login_gov.org_unit_id
}
