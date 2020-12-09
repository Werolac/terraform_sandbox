variable "server_text" {
  description = "The text the web server should return"
  default     = "Hello, World"
  type        = string
}

variable "enable_autoscaling" {
  description = "if set to true, enable autoscaling"
  type        = bool
}
variable "environment" {
  description = "the name of the environment we are deploying to"
  type        = string
}
