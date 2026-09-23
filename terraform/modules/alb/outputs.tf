output "frontend_alb_dns_name" {
  description = "DNS name of the frontend internet-facing ALB."
  value       = aws_lb.frontend.dns_name
}

output "frontend_alb_zone_id" {
  description = "Hosted zone ID of the frontend ALB."
  value       = aws_lb.frontend.zone_id
}

output "frontend_alb_url" {
  description = "URL of the frontend ALB."
  value       = "http://${aws_lb.frontend.dns_name}"
}

output "backend_alb_dns_name" {
  description = "DNS name of the backend internal ALB."
  value       = aws_lb.backend.dns_name
}

output "frontend_alb_arn_suffix" {
  description = "ARN suffix for the frontend ALB used by CloudWatch metrics."
  value       = aws_lb.frontend.arn_suffix
}

output "backend_alb_arn_suffix" {
  description = "ARN suffix for the backend ALB used by CloudWatch metrics."
  value       = aws_lb.backend.arn_suffix
}

output "frontend_target_group_arn" {
  description = "Frontend target group ARN."
  value       = aws_lb_target_group.frontend.arn
}

output "backend_target_group_arn" {
  description = "Backend target group ARN."
  value       = aws_lb_target_group.backend.arn
}
