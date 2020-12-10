provider "aws" {
  region = "us-east-2"
}

module "asg" {
  source             = "D:/terraform_sandbox/modules/cluster/asg-rolling-deploy"
  cluster_name       = "example_asg"
  ami                = "ami-0c55b159cbfafe1f0"
  instance_type      = "t2.micro"
  enable_autoscaling = false
  subnet_ids         = data.aws_subnet_ids.default.ids
  user_data          = "D:/terraform_sandbox/stage/user_data.sh"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}
