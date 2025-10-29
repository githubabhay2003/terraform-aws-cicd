# main.tf: Main infrastructure configuration

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
      random = {
        source  = "hashicorp/random"
        version = "~> 3.0"
      }
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
# --- ADD THIS RESOURCE FOR FINAL TEST ---
resource "random_pet" "test" {
  length = 2
}
# --- END OF TEST RESOURCE ---
