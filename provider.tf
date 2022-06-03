terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-3"
  access_key = <##ACCESS_KEY##>
  secret_key = <##SECRET_KEY##>
 
}
