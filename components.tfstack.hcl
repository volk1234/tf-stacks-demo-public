component "storage" {
  for_each = var.regions

  source = "./level-s"

  inputs = {
    region            = each.key
    env2              = var.env
    environment_code  = "${var.env}-${each.value}"
    queue_name        = "core-${var.env}"
    iam_role_sqs_name = "core-receiver-${var.env}"
    iam_role_sns_name = "receiver-channel-${var.env}"
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