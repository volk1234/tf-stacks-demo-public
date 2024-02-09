resource "aws_key_pair" "core" {
  key_name   = local.node_name
  public_key = data.hcp_vault_secrets_app.aws_app.secrets["public_key"]
}