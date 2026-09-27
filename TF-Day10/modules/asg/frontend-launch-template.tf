resource "aws_launch_template" "frontend" {
  name_prefix   = "${var.project_name}-${var.environment}-frontend-"
  image_id      = var.frontend_ami_id
  instance_type = var.frontend_instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [var.frontend_security_group_id]
  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-${var.environment}-frontend"
    }
  }

  user_data = base64encode(templatefile("${path.module}/../../userdata/frontend.sh", {
    backend_alb_dns_name = var.backend_alb_dns_name
    app_environment      = var.app_environment
    log_group_name       = var.cloudwatch_log_group_name
  }))

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }
}
