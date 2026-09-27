module "alb" {
  source = "../../modules/alb"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id

  public_subnet_ids      = module.vpc.public_subnet_ids
  private_app_subnet_ids = module.vpc.private_app_subnet_ids

  frontend_alb_security_group_id = module.security_groups.frontend_alb_security_group_id
  backend_alb_security_group_id  = module.security_groups.backend_alb_security_group_id
  frontend_security_group_id     = module.security_groups.frontend_security_group_id
  backend_security_group_id      = module.security_groups.backend_security_group_id

  frontend_health_check_path = "/"
  backend_health_check_path  = "/api"
}
