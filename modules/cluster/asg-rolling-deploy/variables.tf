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
variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
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

variable "subnet_ids" {
  description = "The subnet ids to deploy to"
  type        = list(string)
}

variable "target_group_arns" {
  description = "the arns of elb target groups in which to register instances"
  type        = list(string)
  default     = []
}

variable "health_check_type" {
  description = "the type of health chechk to perform. Must be one of: ec2 elb"
  type        = string
  default     = "EC2"
}

variable "user_data" {
  description = "The user data script to run in each instances at boot"
  type        = string
  default     = ""
}
