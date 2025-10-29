# main.tf: Main infrastructure configuration

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Lock to a major version
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
