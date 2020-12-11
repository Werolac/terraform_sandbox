locals {
  http_port    = 80
  any_port     = 0
  any_protocol = -1
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}

resource "aws_lb" "example" {
  name               = var.alb_name
  load_balancer_type = "application"
  subnets            = data.aws_subnet_ids.default.ids
  security_groups    = [aws_security_group.alb.id]
}
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port              = local.http_port
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
  name = var.alb_name
  ingress = [{
    cidr_blocks      = local.all_ips
    description      = "asd"
    from_port        = local.http_port
    ipv6_cidr_blocks = local.all_ips
    prefix_list_ids  = []
    protocol         = local.tcp_protocol
    security_groups  = ["sg-93ba2be2"]
    self             = false
    to_port          = local.http_port
  }]
  egress = [{
    cidr_blocks      = local.all_ips
    description      = "asd"
    from_port        = local.any_port
    ipv6_cidr_blocks = local.all_ips
    prefix_list_ids  = []
    protocol         = local.any_protocol
    security_groups  = ["sg-93ba2be2"]
    self             = false
    to_port          = local.any_port
  }]
}
