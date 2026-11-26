terraform {
  backend "s3" {
    bucket       = "aryan-connect-tfstate-2026"
    key          = "ar-connect/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.73.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}