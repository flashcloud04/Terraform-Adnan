output "frontend_alb_security_group_id" {
  description = "Security group ID for the internet-facing frontend ALB."
  value       = aws_security_group.frontend_alb.id
}

output "frontend_security_group_id" {
  description = "Security group ID for frontend EC2 instances."
  value       = aws_security_group.frontend.id
}

output "backend_alb_security_group_id" {
  description = "Security group ID for the internal backend ALB."
  value       = aws_security_group.backend_alb.id
}

output "backend_security_group_id" {
  description = "Security group ID for backend EC2 instances."
  value       = aws_security_group.backend.id
}

output "rds_security_group_id" {
  description = "Security group ID for the MySQL database."
  value       = aws_security_group.rds.id
}
