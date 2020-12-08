output "all_names" {
  value = aws_iam_user.example
}

output "short_upper_names" {
  value = [for name in var.user_names : upper(name) if length(name) < 5]
}

output "bios" {
  value = [for name, role in var.hero_thousand_faces :
  "${name} is the ${role}"]
}
