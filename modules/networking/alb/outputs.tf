output "alb_dns_name" {
  description = "the domain name of the load balancer"
  value       = aws_lb.example.dns_name
}

output "alb_http_listener_arn" {
  value       = aws_lb_listener.http.arn
  description = "The arn of the http listener"
}

output "alb_security_group_id" {
  value       = aws_security_group.alb.id
  description = "The ALB security group id"
}
