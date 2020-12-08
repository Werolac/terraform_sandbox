variable "user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["vladimir", "natasha", "alexander"]
}

variable "hero_thousand_faces" {
  description = "map"
  type        = map(string)
  default = {
    vladimir  = "hero"
    natasha   = "love interest"
    alexander = "boss"
  }
}
