resource "aws_launch_template" "backend" {
  name_prefix   = "${var.project_name}-${var.environment}-backend-"
  image_id      = var.backend_ami_id
  instance_type = var.backend_instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [var.backend_security_group_id]
  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-${var.environment}-backend"
    }
  }

  user_data = base64encode(templatefile("${path.module}/../../userdata/backend.sh", {
    app_environment      = var.app_environment
    database_host        = var.database_host
    database_name        = var.database_name
    database_user        = var.database_user
    database_password    = var.database_password
    secret_arn           = var.secret_arn
    log_group_name       = var.cloudwatch_log_group_name
    app_repository       = var.app_repository
  }))

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }
}
