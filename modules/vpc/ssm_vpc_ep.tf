resource "aws_security_group" "vpc_endpoint_sg" {
  name        = "${var.application_name}-vpc-endpoint-sg"
  description = "${var.application_name} VPC Endpoint SG"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.application_name}-vpcep-sg"
  }

  lifecycle {
    ignore_changes = [description, tags]
  }
}

resource "aws_security_group_rule" "vpc_endpoint_sg_ingress" {
  security_group_id = aws_security_group.vpc_endpoint_sg.id

  type        = "ingress"
  cidr_blocks = [aws_vpc.main.cidr_block]
  protocol    = "tcp"
  from_port   = 443
  to_port     = 443
}

resource "aws_security_group_rule" "vpc_endpoint_sg_egress" {
  security_group_id = aws_security_group.vpc_endpoint_sg.id

  type        = "egress"
  cidr_blocks = [local.internet_cidr]
  protocol    = "-1"
  from_port   = 0
  to_port     = 0
}

resource "aws_ec2_tag" "vpc_endpoint_sg_ingress" {
  resource_id = aws_security_group_rule.vpc_endpoint_sg_ingress.security_group_rule_id
  key         = "Name"
  value       = "${var.application_name}-vpc-endpoint-ingress"
}

resource "aws_ec2_tag" "vpc_endpoint_sg_egress" {
  resource_id = aws_security_group_rule.vpc_endpoint_sg_egress.security_group_rule_id
  key         = "Name"
  value       = "${var.application_name}-vpc-endpoint-egress"
}

resource "aws_vpc_endpoint" "ssm" {
  for_each = local.ssm

  vpc_id              = aws_vpc.main.id
  service_name        = each.value.service_name
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.privates[*].id
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  private_dns_enabled = true

  tags = {
    Name = each.value.name
  }
}
