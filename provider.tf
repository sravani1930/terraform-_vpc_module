terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.25.0"
    }
  }
}


terraform {
  backend "s3" {
    bucket = "devopsify-remote-state"
    key    = "vpc"
    region = "us-east-1"
    dynamodb_table = "devopsify-locking"
  }
}


provider "aws" {
  # Configuration options
}