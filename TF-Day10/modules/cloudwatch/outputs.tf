output "frontend_log_group_name" {
  description = "Frontend application log group name."
  value       = aws_cloudwatch_log_group.frontend.name
}

output "backend_log_group_name" {
  description = "Backend application log group name."
  value       = aws_cloudwatch_log_group.backend.name
}
