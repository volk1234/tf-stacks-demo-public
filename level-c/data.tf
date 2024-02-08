data "hcp_vault_secrets_app" "aws_app" {
  app_name = "tf-stack-demo"
}

data "aws_vpc" "main" {
  provider = aws.core

  filter {
    name   = "tag:Name"
    values = ["main-${var.environment_code}"]
  }
}

data "aws_subnet" "main1" {
  provider = aws.core

  filter {
    name   = "tag:Name"
    values = ["main-1-${var.environment_code}"]
  }
}

data "aws_subnet" "main2" {
  provider = aws.core

  filter {
    name   = "tag:Name"
    values = ["main-2-${var.environment_code}"]
  }
}

data "aws_security_group" "https" {
  provider = aws.core

  vpc_id = data.aws_vpc.main.id

  filter {
    name   = "tag:Name"
    values = ["allow_https_${var.environment_code}"]
  }
}

data "aws_ami" "amazon2" {
  provider = aws.core

  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-*-hvm-*-x86_64-gp2"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }

  owners = ["amazon"]
}
