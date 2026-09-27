module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
  environment  = var.environment

  secret_arn             = module.secrets.secret_arn
  application_bucket_arn = module.application_artifact.bucket_arn
}