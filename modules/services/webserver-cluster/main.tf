resource "aws_security_group" "instance" {
  name = "${var.cluster_name}instance"
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "this is an example"
    from_port        = var.server_port
    ipv6_cidr_blocks = ["0.0.0.0/0"]
    protocol         = "tcp"
    self             = false
    to_port          = var.server_port
    prefix_list_ids  = []
    security_groups  = ["sg-93ba2be2"]
  }]

}

resource "aws_launch_configuration" "example" {
  image_id        = "ami-0c55b159cbfafe1f0"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instance.id]
  user_data       = data.template_file.user_data.rendered
  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name
  vpc_zone_identifier  = data.aws_subnet_ids.default.ids

  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = var.cluster_name
    propagate_at_launch = true
  }

}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_lb" "example" {
  name               = var.cluster_name
  load_balancer_type = "application"
  subnets            = data.aws_subnet_ids.default.ids
  security_groups    = [aws_security_group.alb.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

resource "aws_security_group" "alb" {
  name = "${var.cluster_name}-alb"
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "asd"
    from_port        = 80
    ipv6_cidr_blocks = ["0.0.0.0/0"]
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = ["sg-93ba2be2"]
    self             = false
    to_port          = 80
  }]
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "asd"
    from_port        = 0
    ipv6_cidr_blocks = ["0.0.0.0/0"]
    prefix_list_ids  = []
    protocol         = -1
    security_groups  = ["sg-93ba2be2"]
    self             = false
    to_port          = 0
  }]
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

data "template_file" "user_data" {
  template = file("user_data.sh")
  vars = {
    server_port = var.server_port
  }
}