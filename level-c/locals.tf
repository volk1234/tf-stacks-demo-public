locals {

  node_name = "core-demo-${var.environment_code}"

  tags = {
    terraform_state     = "level-c"
    terraform_workspace = var.environment_code
  }

}
