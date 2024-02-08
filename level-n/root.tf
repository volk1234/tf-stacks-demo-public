provider "aws" {
  region = var.region
  alias  = "core"
}

terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "tetheus-corp"
  }

  required_version = ">= 1.7.2"

  required_providers {
    aws = {
      version = "5.35.0"
    }

    kubernetes = {
      version = "2.25.2"
    }
  }
}
