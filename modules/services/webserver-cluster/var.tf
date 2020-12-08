variable "cluster_name" {
  description = "The name to use for all the cluster resources"
  type        = string
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

variable "enable_autoscaling" {
  description = "If set to true, enable auto scaling"
  type        = bool
}

variable "enable_new_user_data" {
  description = "If set to true, use the new User Data script"
  type        = bool
}
