resource "aws_vpc" "main" {
  provider = aws.core

  cidr_block = var.cidr
  tags = merge(
    {
      "Name" = "main-${var.environment_code}"
    },
    local.tags,
  )
}

resource "aws_subnet" "main_0" {
  provider = aws.core

  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr, 1, 0)
  tags = merge(
    {
      "Name" = "main-1-${var.environment_code}"
    },
    local.tags,
  )
}

resource "aws_subnet" "main_1" {
  provider = aws.core

  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr, 1, 1)
  tags = merge(
    {
      "Name" = "main-2-${var.environment_code}"
    },
    local.tags,
  )
}
