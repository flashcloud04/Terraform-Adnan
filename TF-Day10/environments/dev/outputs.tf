output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_app_subnet_ids" {
  value = module.vpc.private_app_subnet_ids
}

output "private_db_subnet_ids" {
  value = module.vpc.private_db_subnet_ids
}

output "nat_gateway_id" {
  value = module.vpc.nat_gateway_id
}

output "frontend_alb_dns_name" {
  value = module.alb.frontend_alb_dns_name
}

output "frontend_alb_url" {
  value = module.alb.frontend_alb_url
}

output "backend_alb_dns_name" {
  value = module.alb.backend_alb_dns_name
}

output "frontend_asg_name" {
  value = module.asg.frontend_asg_name
}

output "backend_asg_name" {
  value = module.asg.backend_asg_name
}

output "rds_endpoint" {
  value = module.rds.database_endpoint
}

output "rds_port" {
  value = module.rds.database_port
}

output "rds_identifier" {
  value = module.rds.database_identifier
}
