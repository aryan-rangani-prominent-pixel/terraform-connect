terraform {
  backend "s3" {
    bucket = "there-is-a-bucket-for-state-locking"
    key = "dev/for development"
    encrypt = true
    region = "us-east-1"
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