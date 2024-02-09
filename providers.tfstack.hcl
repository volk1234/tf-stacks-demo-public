required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.35.0"
  }
}

provider "aws" "configurations" {
  for_each = toset(formatlist("%s", range(length(var.regions))))

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
