provider "aws" {
  region = "us-east-2"
}

module "alb" {
  source     = "D:/terraform_sandbox/modules/networking/alb"
  alb_name   = "forTestingPurposes"
  subnet_ids = data.aws_subnet_ids.default.ids
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}
