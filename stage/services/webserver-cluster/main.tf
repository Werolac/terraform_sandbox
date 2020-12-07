provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {
  source = "C:/work/git_project/terraform_sandbox/modules/services/webserver-cluster"
}