required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.35.0"
  }

  hcp = {
    source  = "hashicorp/hcp"
    version = "~> 0.82.0"
  }

  local = {
    source = "hashicorp/local"
    version = "~> 2.4.0"
  }
}

provider "aws" "core" {
  for_each = var.regions

  config {
    region = each.value

    assume_role_with_web_identity {
      role_arn                = var.role_arn
      web_identity_token_file = var.identity_token_file
    }

    default_tags {
      tags = var.default_tags
    }
  }
}

provider "local" "this" {}