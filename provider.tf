terraform {
  cloud {
    organization = "HashiCorp_AWS_Org"

    workspaces {
      tags = {
        "env" = "secrets-sync",
      }
    }
  }

  required_providers {
    vault = {
      version = "~> 5.5.0"
      source  = "hashicorp/vault"
    }
    aws = {
      version = "~> 6.21.0"
      source  = "hashicorp/aws"
    }
  }
}
provider "aws" {
  region = var.region
  default_tags {
    tags = local.tags

  }
}
