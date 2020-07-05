terraform {
  backend "s3" {
    bucket   = "cloudops-newsandbox.tfstate-bucket"
    key      = "ebs_sched_git/terraform.tfstate"
    region   = "eu-west-1"
    role_arn = "arn:aws:iam::324382802360:role/SSOAdmin"
    encrypt  = "true"
  }
}

provider "aws" {
  region = "eu-west-2"

  assume_role {
    role_arn = "arn:aws:iam::324382802360:role/SSOAdmin"
  }
}

