module "rds" {
  source = "../../modules/rds"

  project_name = var.project_name
  environment  = var.environment

  db_subnet_ids        = module.vpc.private_db_subnet_ids
  vpc_id               = module.vpc.vpc_id
  db_security_group_id = module.security_groups.rds_security_group_id

  database_name     = var.database_name
  database_username = var.database_user
  database_password = var.database_password

  instance_class          = var.rds_instance_class
  allocated_storage       = var.rds_allocated_storage
  max_allocated_storage   = var.rds_max_allocated_storage
  backup_retention_period = var.rds_backup_retention_period
  multi_az                = var.rds_multi_az
  deletion_protection     = var.rds_deletion_protection
  skip_final_snapshot     = var.rds_skip_final_snapshot
  engine_version          = var.rds_engine_version
  db_port                 = var.rds_port
}
