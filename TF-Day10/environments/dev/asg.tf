locals {
  frontend_ami_id = var.frontend_ami_id != null ? var.frontend_ami_id : data.aws_ami.amazon_linux_2023.id
  backend_ami_id  = var.backend_ami_id != null ? var.backend_ami_id : data.aws_ami.amazon_linux_2023.id
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

module "asg" {
  source = "../../modules/asg"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id

  private_app_subnet_ids = module.vpc.private_app_subnet_ids

  frontend_security_group_id = module.security_groups.frontend_security_group_id
  backend_security_group_id  = module.security_groups.backend_security_group_id

  iam_instance_profile_name = module.iam.ec2_instance_profile_name

  frontend_target_group_arn = module.alb.frontend_target_group_arn
  backend_target_group_arn  = module.alb.backend_target_group_arn

  frontend_ami_id        = local.frontend_ami_id
  backend_ami_id         = local.backend_ami_id
  frontend_instance_type = var.frontend_instance_type
  backend_instance_type  = var.backend_instance_type
  key_name               = var.key_name

  frontend_min_size         = var.frontend_min_size
  frontend_desired_capacity = var.frontend_desired_capacity
  frontend_max_size         = var.frontend_max_size

  backend_min_size         = var.backend_min_size
  backend_desired_capacity = var.backend_desired_capacity
  backend_max_size         = var.backend_max_size

  backend_alb_dns_name = module.alb.backend_alb_dns_name

  secret_arn = module.secrets.secret_arn

  application_bucket_name = module.application_artifact.bucket_name
  application_object_key  = module.application_artifact.object_key

  app_environment = var.environment

  cloudwatch_log_group_name = "/aws/ec2/${var.project_name}-${var.environment}/frontend"
}