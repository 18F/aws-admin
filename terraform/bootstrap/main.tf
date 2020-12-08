provider "aws" {
  version = "~> 2.32"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "backend" {
  bucket = "tts-aws-admin"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  lifecycle {
    prevent_destroy = true
  }
  versioning {
    enabled = true
    mfa_delete = true
  }
  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "tfstate/"
  }
  tags = {
    Project = "https://github.com/18F/aws-admin"
  }
}

# https://github.com/monterail/terraform-bootstrap-example/blob/3b3ecce9a06cd9f1d1a513d877477a22edbf9326/modules/backend/main.tf#L85-L101
resource "aws_dynamodb_table" "state_lock" {
  name           = "aws-admin-terraform-state-lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"
  point_in_time-recovery {
   enabled = true
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Project = "https://github.com/18F/aws-admin"
  }
}
