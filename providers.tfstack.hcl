required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.78.0"
  }
  
  hcp = {
      source  = "hashicorp/hcp"
      version = "0.99.0"
    }
}

provider "aws" "configurations" {
  for_each = var.regions

  config {
    region = each.key

    assume_role_with_web_identity {
      role_arn                = var.role_arn
      web_identity_token_file = var.identity_token_file
    }

    default_tags {
      tags = var.default_tags
    }
  }
}

provider "hcp" "this" {
  config {
    workload_identity {
      resource_name = var.workload_idp_name
      token_file    = var.identity_token_file_vault
    }
  }
}
