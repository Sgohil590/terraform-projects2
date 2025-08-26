terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.9.0"  # or another version you want
    }
  }

  required_version = ">= 1.4.0"
}

