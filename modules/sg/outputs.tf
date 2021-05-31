output "id" {
  description = "ID of the Security Group"
  value       = length(aws_security_group.default) != 0 ? aws_security_group.default[0].id : null
}

output "name" {
  description = "Name of the Security Group"
  value       = length(aws_security_group.default) != 0 ? aws_security_group.default[0].name : null
}
