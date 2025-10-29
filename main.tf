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
# --- ADD THIS RESOURCE FOR COST ESTIMATION ---
# (We will remove it later)

# 1. Get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# 2. Create a t3.micro EC2 instance
resource "aws_instance" "test_vm" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t3.micro" # This has a small cost

  tags = {
    Name = "cost-estimation-test"
  }
}
# --- END OF COST RESOURCE ---
