output "ec2_role_name" {
  description = "IAM role name assigned to EC2 instances."
  value       = aws_iam_role.ec2.name
}

output "ec2_instance_profile_name" {
  description = "IAM instance profile name used by EC2 instances."
  value       = aws_iam_instance_profile.ec2.name
}
