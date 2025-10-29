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

# This is the NEW insecure part. We are explicitly
# turning OFF all the "block public access" settings.
resource "aws_s3_bucket_public_access_block" "insecure_block" {
  bucket = aws_s3_bucket.insecure_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
# --- END OF INSECURE RESOURCE ---
