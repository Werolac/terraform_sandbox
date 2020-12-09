module "alb" {
  source     = "D:/terraform_sandbox/modules/networking/alb"
  alb_name   = "hello-world-${var.environment}"
  subnet_ids = data.aws_subnet_ids.default.ids
}
module "asg" {
  source             = "D:/terraform_sandbox/modules/cluster/asg-rolling-deploy"
  cluster_name       = "hello-world-${var.environment}"
  ami                = var.ami
  user_data          = data.template_file.user_data.rendered
  instance_type      = var.instance_type
  enable_autoscaling = var.enable_autoscaling
  subnet_ids         = data.aws_subnet_ids.default.ids
  target_group_arn   = [aws_lb_target_group.asg.arn]
  health_check       = "ELB"
  custom_tags        = var.custom_tags

}
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

data "template_file" "user_data" {
  template = file("user_data.sh")
  vars = {
    server_port = var.server_port
    server_text = var.server_text
  }
}

resource "aws_lb_target_group" "asg" {
  name     = var.cluster_name
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100
  condition {
    path_pattern {
      values = ["*"]
    }
  }
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }

}
