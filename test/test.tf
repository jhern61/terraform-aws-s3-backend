terraform {
  backend "s3" {
    bucket         = "team-rocket-oe7gpsewf95b-state-bucket"
    key            = "jesse/james"
    region         = "us-west-2"
    encrypt        = true
    role_arn       = "arn:aws:iam::017735233214:role/team-rocket-oe7gpsewf95b-tf-assume-role"
    dynamodb_table = "team-rocket-oe7gpsewf95b-state-lock"
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
