component "storage" {
  for_each = var.regions

  source = "./level-s"

  inputs = {
    region            = each.key
    environment_code  = "${var.env}-${each.value}"
    queue_name        = "core"
    iam_role_sqs_name = "core-receiver-${var.env}-${each.value}"
    iam_role_sns_name = "receiver-channel-${var.env}-${each.value}"
  }

  providers = {
    aws     = provider.aws.configurations[each.key]
  }
}

component "network" {
  for_each = var.regions

  source = "./level-n"

  inputs = {
    region            = each.key
    environment_code  = "${var.env}-${each.value}"
    cidr              = var.cidr
  }

  providers = {
    aws     = provider.aws.configurations[each.key]
  }
}

component "compute" {
  for_each = var.regions

  source = "./level-c"

  inputs = {
    region            = each.key
    environment_code  = "${var.env}-${each.value}"
  }

  providers = {
    aws     = provider.aws.configurations[each.key]
    hcp     = provider.hcp.this
  }
}
