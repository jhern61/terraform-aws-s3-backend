terraform {
  backend "s3" {
    bucket         = "team-rocket-oe7gpsewf95b-state-bucket"
    key            = "team1/my-cool-project"
    region         = "us-west-2"
    encrypt        = true
    role_arn       = "arn:aws:iam::017735233214:role/team-rocket-oe7gpsewf95b-tf-assume-role"
    dynamodb_table = "team-rocket-oe7gpsewf95b-state-lock"
    profile        = "tfuser1"
  }
  required_version = ">= 0.15"
}

variable "region" {
  description = "AWS region"
  type        = string
}

provider "aws" {
  region  = var.region
  profile = "tfuser1"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  tags = {
    "Name" = terraform.workspace
  }
}
