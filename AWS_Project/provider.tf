terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.9.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
    # region = "ap-south-1"
  # Configuration options
}