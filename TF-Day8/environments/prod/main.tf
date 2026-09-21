module "lambda" {
  source = "../../modules/lambda"

  function_name   = var.lambda_function_name
  lambda_role_arn = var.lambda_role_arn
  source_file     = "${path.root}/../../lambda/app.py"

  tags = {
    Environment = var.environment
    Project     = "terraform-lambda"
    ManagedBy   = "Terraform"
  }
}
