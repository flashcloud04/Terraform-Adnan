terraform {
  required_version = ">= 1.10.0"

  backend "s3" {
    bucket       = "cloud-platform-dev-artifacts-f3011686ca55be26854f0c1a54"
    key          = "environments/dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
  }
}