terraform {
  required_version = ">=1.7.5"
  backend "local" {
    path = "terraform.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.62.0"
    }
  }
}
