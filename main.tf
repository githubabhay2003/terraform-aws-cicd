# main.tf: Main infrastructure configuration

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# --- ADD THIS INSECURE RESOURCE ---
# This S3 bucket is deliberately insecure for testing tfsec

resource "aws_s3_bucket" "insecure_bucket" {
  bucket = "my-insecure-tfsec-test-bucket-12345" # Make sure this is still unique
}
