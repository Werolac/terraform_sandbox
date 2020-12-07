provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {
  source = "C:/work/git_project/terraform_sandbox/modules/services/webserver-cluster"
  cluster_name = "webserver-stage"
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scale-out-during-business-hours"
  min_size = 2
  max_size = 5
  desired_capacity = 5
  recurrence = "0 9 * * *"
  autoscaling_group_name = module.webserver_cluster.asg_name
}
resource "aws_autoscaling_schedule" "scale_in_at_nights" {
  scheduled_action_name = "scale-in-at-night"
  min_size = 1
  max_size = 2
  desired_capacity = 2
  recurrence = "0 17 * * *"
  autoscaling_group_name = module.webserver_cluster.asg_name
}