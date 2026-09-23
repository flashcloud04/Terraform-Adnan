module "application_artifact" {
  source = "../../modules/application-artifact"

  project_name = var.project_name
  environment  = var.environment
}