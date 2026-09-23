terraform {
  backend "s3" {
    bucket       = "terraform-backend-e-commerce"
    key          = "aws-ecommerce-platform/dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
