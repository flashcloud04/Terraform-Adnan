output "secret_arn" {
  description = "ARN of the application secret in AWS Secrets Manager."
  value       = aws_secretsmanager_secret.app.arn
  sensitive   = true
}

output "secret_name" {
  description = "Name of the application secret in AWS Secrets Manager."
  value       = aws_secretsmanager_secret.app.name
}
