terraform {
  required_version = "~> 0.12.0"

  backend "s3" {
    # needs to match bootstrap module
    bucket         = "tts-aws-admin"
    key            = "terraform/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "aws-admin-terraform-state-lock"
  }

  required_providers {
    aws = {
      version = ">= 3.0"
    }
    local = {
      version = ">= 1.4"
    }
  }
}

# jump account
provider "aws" {
  # arbitrary, since most of these resources are global
  region = "us-east-1"
}

resource "aws_iam_group" "admins" {
  name = "tts-tech-portfolio-admins"
}
