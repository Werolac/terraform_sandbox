provider "aws" {
  region = "us-east-2"
}

module "hello_world_app" {
  //source = "D:/terraform_sandbox/modules/services/hello-world-app"
  source       = "github.com/Werolac/terraform_sandbox?ref=v.0.0.5"
  ami          = "ami-0c55b159cbfafe1f0"
  server_text  = "New server text"
  cluster_name = "webserver-stage"
  custom_tags = {
    Owner      = "team-foo"
    DeployedBy = "terraform"
  }
  instance_type      = "t2.micro"
  enable_autoscaling = true
  environment        = "staging"
}
