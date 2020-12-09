provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {
  source       = "D:/terraform_sandbox/modules/services/webserver-cluster"
  ami          = "ami-0c55b159cbfafe1f0"
  server_text  = "New server text"
  cluster_name = "webserver-stage"
  custom_tags = {
    Owner      = "team-foo"
    DeployedBy = "terraform"
  }
  instance_type      = "t2.micro"
  enable_autoscaling = true
}
