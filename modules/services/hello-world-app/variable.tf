variable "environment" {
  description = "the name of the environment we are deploying to"
  type        = string
}
variable "cluster_name" {
  description = "The name to use for all the cluster resources"
  type        = string
}
variable "ami" {
  description = "The AMI to run in the cluster"
  default     = "ami-0c55b159cbfafe1f0"
  type        = string
}
variable "instance_type" {
  description = "The type of instance to run"
  default     = "t2.micro"
  type        = string
}
variable "enable_autoscaling" {
  description = "If set to true, enable auto scaling"
  type        = bool
}

variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG"
  type        = map(string)
  default     = {}
}

variable "server_text" {
  description = "The text the web server should return"
  default     = "Hello, World"
  type        = string
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}
