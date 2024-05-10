resource "aws_security_group" "nat" {
  name        = "${var.application_name}-nat-sg"
  description = "${var.application_name} nat SG"
  vpc_id      = var.vpc.id

  egress = [
    {
      cidr_blocks = [
        local.internet_cidr
      ]
      description      = "ping"
      from_port        = -1
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "icmp"
      security_groups  = []
      self             = false
      to_port          = -1
    },
    {
      cidr_blocks = [
        local.internet_cidr
      ]
      description      = "https"
      from_port        = 443
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 443
    },
    {
      cidr_blocks = [
        local.internet_cidr
      ]
      description      = "http"
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
    },
  ]
  ingress = [
    {
      cidr_blocks      = var.private_subnet_cidr
      description      = "ping"
      from_port        = -1
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "icmp"
      security_groups  = []
      self             = false
      to_port          = -1
    },
    {
      cidr_blocks      = var.private_subnet_cidr
      description      = "https"
      from_port        = 443
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 443
    },
    {
      cidr_blocks      = var.private_subnet_cidr
      description      = "http"
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
    },
  ]
  revoke_rules_on_delete = false

  tags = {
    Name = "${var.application_name}-nat-sg"
  }

  lifecycle {
    ignore_changes = [description, tags]
  }
}
