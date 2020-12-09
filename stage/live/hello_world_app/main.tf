provider "aws" {
  region = "us-east-2"
}

module "hello_world_app" {
  source             = "D:/terraform_sandbox/modules/services/hello-world-app"
  ami                = "ami-0c55b159cbfafe1f0"
  server_text        = var.server_text
  environment        = var.environment
  instance_type      = "t2.micro"
  enable_autoscaling = true
}
