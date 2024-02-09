resource "aws_security_group" "web_access" {
  name        = "allow_https_${var.environment_code}"
  description = "Allow HTTPS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_https_${var.environment_code}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.web_access.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.web_access.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}