module "cloudwatch" {
  source = "../../modules/cloudwatch"

  project_name = var.project_name
  environment  = var.environment

  frontend_asg_name = module.asg.frontend_asg_name
  backend_asg_name  = module.asg.backend_asg_name

  frontend_alb_arn_suffix = module.alb.frontend_alb_arn_suffix
  backend_alb_arn_suffix  = module.alb.backend_alb_arn_suffix

  rds_instance_identifier = module.rds.database_identifier
}
