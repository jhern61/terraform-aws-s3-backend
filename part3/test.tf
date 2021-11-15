terraform {
  backend "s3" {
    bucket         = "team-rocket-s0g8q6sl7fsb-state-bucket"
    key            = "jesse/james"
    region         = "us-west-2"
    encrypt        = true
    role_arn       = "arn:aws:iam::017735233214:role/team-rocket-s0g8q6sl7fsb-tf-assume-role"
    dynamodb_table = "team-rocket-s0g8q6sl7fsb-state-lock"
    profile        = "tfuser1"
  }
  required_version = ">= 0.15"
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

resource "null_resource" "motto" {
  triggers = {
    always = timestamp()
  }
  provisioner "local-exec" {
    command = "echo gotta catch em all"
  }
}
