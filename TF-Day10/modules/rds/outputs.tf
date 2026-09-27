output "database_endpoint" {
  description = "RDS endpoint address."
  value       = aws_db_instance.this.address
}

output "database_port" {
  description = "RDS port."
  value       = aws_db_instance.this.port
}

output "database_name" {
  description = "RDS database name."
  value       = aws_db_instance.this.db_name
}

output "database_identifier" {
  description = "RDS database identifier."
  value       = aws_db_instance.this.identifier
}

output "security_group_id" {
  description = "RDS security group ID."
  value       = var.db_security_group_id
}
