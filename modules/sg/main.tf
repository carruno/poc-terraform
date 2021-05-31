
locals {
  ingress_tcp_range = (var.ingress_tcp_range_from != "default_null" && var.ingress_tcp_range_to != "default_null")
  ingress_udp_range = (var.ingress_udp_range_from != "default_null" && var.ingress_udp_range_to != "default_null")
  egress_tcp_range  = (var.egress_tcp_range_from != "default_null" && var.egress_tcp_range_to != "default_null")
  egress_udp_range  = (var.egress_udp_range_from != "default_null" && var.egress_udp_range_to != "default_null")
}

#############################
# Security Group
#############################

resource "aws_security_group" "default" {
  count = var.enabled ? 1 : 0

  name        = var.sg_name
  description = var.sg_name

  # Network
  vpc_id = var.vpc_id

  # Tags
  tags = merge(var.tags, tomap({
    Name = var.sg_name
  }))
}

#############################
# Ingress Traffic - TCP
#############################

# Ingress rules for TCP traffic
resource "aws_security_group_rule" "ingress_tcp_range" {
  count = (var.enabled && local.ingress_tcp_range) ? 1 : 0

  # General
  description = "TCP ingress traffic"

  # Security Group
  security_group_id = aws_security_group.default[0].id

  # Rule
  type        = "ingress"
  protocol    = "tcp"
  from_port   = var.ingress_tcp_range_from
  to_port     = var.ingress_tcp_range_to
  cidr_blocks = var.ingress_cidrs
}

# Loop on the Ingress rules for TCP traffic
resource "aws_security_group_rule" "ingress_tcp_port" {
  count = (var.enabled && var.ingress_tcp_ports != "default_null") ? length(split(",", var.ingress_tcp_ports)) : 0

  # General
  description = "TCP ingress traffic"

  # Security Group
  security_group_id = aws_security_group.default[0].id

  # Rule
  type        = "ingress"
  protocol    = "tcp"
  from_port   = element(split(",", var.ingress_tcp_ports), count.index)
  to_port     = element(split(",", var.ingress_tcp_ports), count.index)
  cidr_blocks = var.ingress_cidrs
}

#############################
# Ingress Traffic - UDP
#############################

# Ingress rules for UDP traffic
resource "aws_security_group_rule" "ingress_udp_range" {
  count = (var.enabled && local.ingress_udp_range) ? 1 : 0

  # General
  description = "UDP ingress traffic"

  # Security Group
  security_group_id = aws_security_group.default[0].id

  # Rule
  type        = "ingress"
  protocol    = "udp"
  from_port   = var.ingress_udp_range_from
  to_port     = var.ingress_udp_range_to
  cidr_blocks = var.ingress_cidrs
}

# Loop on the Ingress rules for UDP traffic
resource "aws_security_group_rule" "ingress_udp_port" {
  count = (var.enabled && var.ingress_udp_ports != "default_null") ? length(split(",", var.ingress_udp_ports)) : 0

  # General
  description = "UDP ingress traffic"

  # Security Group
  security_group_id = aws_security_group.default[0].id

  # Rule
  type        = "ingress"
  protocol    = "udp"
  from_port   = element(split(",", var.ingress_udp_ports), count.index)
  to_port     = element(split(",", var.ingress_udp_ports), count.index)
  cidr_blocks = var.ingress_cidrs
}

#############################
# Ingress Traffic - ICMP
#############################

# Ingress rules for ICMP traffic
resource "aws_security_group_rule" "ingress_icmp" {
  count = (var.enabled && var.enable_icmp) ? 1 : 0

  # General
  description = "ICMP ingress traffic"

  # Security Group
  security_group_id = aws_security_group.default[0].id

  # Rule
  type        = "ingress"
  protocol    = "icmp"
  from_port   = -1
  to_port     = -1
  cidr_blocks = var.ingress_cidrs
}

#############################
# Egress Traffic - TCP
#############################

# Egress rules for TCP traffic
resource "aws_security_group_rule" "egress_tcp_range" {
  count = (var.enabled && local.egress_tcp_range) ? 1 : 0

  # General
  description = "TCP egress traffic"

  # Security Group
  security_group_id = aws_security_group.default[0].id

  # Rule
  type        = "egress"
  protocol    = "tcp"
  from_port   = var.egress_tcp_range_from
  to_port     = var.egress_tcp_range_to
  cidr_blocks = var.egress_cidrs
}

# Loop on the Egress rules for TCP traffic
resource "aws_security_group_rule" "egress_tcp_port" {
  count = (var.enabled && var.egress_tcp_ports != "default_null") ? length(split(",", var.egress_tcp_ports)) : 0

  # General
  description = "TCP egress traffic"

  # Security Group
  security_group_id = aws_security_group.default[0].id

  # Rule
  type        = "egress"
  protocol    = "tcp"
  from_port   = element(split(",", var.egress_tcp_ports), count.index)
  to_port     = element(split(",", var.egress_tcp_ports), count.index)
  cidr_blocks = var.egress_cidrs
}

#############################
# Egress Traffic - UDP
#############################

# Egress rules for UDP traffic
resource "aws_security_group_rule" "egress_udp_range" {
  count = (var.enabled && local.egress_udp_range ? 1 : 0)

  # General
  description = "UDP egress traffic"

  # Security Group
  security_group_id = aws_security_group.default[0].id

  # Rule
  type        = "egress"
  protocol    = "udp"
  from_port   = var.egress_udp_range_from
  to_port     = var.egress_udp_range_to
  cidr_blocks = var.egress_cidrs
}

# Loop on the Egress rules for UDP traffic
resource "aws_security_group_rule" "egress_udp_port" {
  count = (var.enabled && var.egress_udp_ports != "default_null") ? length(split(",", var.egress_udp_ports)) : 0

  # General
  description = "UDP egress traffic"

  # Security Group
  security_group_id = aws_security_group.default[0].id

  # Rule
  type        = "egress"
  protocol    = "udp"
  from_port   = element(split(",", var.egress_udp_ports), count.index)
  to_port     = element(split(",", var.egress_udp_ports), count.index)
  cidr_blocks = var.egress_cidrs
}

#############################
# Egress Traffic - ICMP
#############################

# Egress rules for ICMP traffic
resource "aws_security_group_rule" "egress_icmp" {
  count = (var.enabled && var.enable_icmp ? 1 : 0)

  # General
  description = "ICMP egress traffic"

  # Security Group
  security_group_id = aws_security_group.default[0].id

  # Rule
  type        = "egress"
  protocol    = "icmp"
  from_port   = -1
  to_port     = -1
  cidr_blocks = var.egress_cidrs
}

#############################
# Egress Traffic - NAT Gateway
#############################

# Egress rules for NAT Gateway traffic (80)
resource "aws_security_group_rule" "egress_nat_gateway_80" {
  count = (var.enabled && var.is_private_subnet ? 1 : 0)

  # General
  description = "NAT Gateway egress traffic"

  # Security Group
  security_group_id = aws_security_group.default[0].id

  # Rule
  type        = "egress"
  protocol    = "tcp"
  from_port   = 80
  to_port     = 80
  cidr_blocks = ["0.0.0.0/0"]
}

# Egress rules for NAT Gateway traffic (443)
resource "aws_security_group_rule" "egress_nat_gateway_443" {
  count = (var.enabled && var.is_private_subnet ? 1 : 0)

  # General
  description = "NAT Gateway egress traffic"

  # Security Group
  security_group_id = aws_security_group.default[0].id

  # Rule
  type        = "egress"
  protocol    = "tcp"
  from_port   = 443
  to_port     = 443
  cidr_blocks = ["0.0.0.0/0"]
}
