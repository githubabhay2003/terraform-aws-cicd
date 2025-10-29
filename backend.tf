# backend.tf: Configures the remote state storage

terraform {
  backend "s3" {
    bucket         = "abhay-tf-state-project-2025"
    key            = "global/terraform.tfstate" # We'll store the state file in a 'global' folder
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true # Best practice: encrypt the state file at rest
  }
}

