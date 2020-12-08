provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {
  source       = "D:/terraform_sandbox/modules/services/webserver-cluster"
  cluster_name = "webserver-stage"
  custom_tags = {
    Owner      = "team-foo"
    DeployedBy = "terraform"
  }
  enable_autoscaling   = true
  enable_new_user_data = true
}
