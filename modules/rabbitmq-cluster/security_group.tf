resource "aws_security_group" "this" {
  name   = "${var.app_name}-rabbit-sg"
  vpc_id = data.aws_vpc.selected.id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.app_name}-rabbit-sg"
    Product = var.app_name
  }
}

# Allow access from the private subnets
resource "aws_security_group_rule" "this" {
  cidr_blocks       = [for s in data.aws_subnet.private : s.cidr_block]
  description       = "private subnet"
  from_port         = 5672
  to_port           = 5672
  protocol          = "tcp"
  type              = "ingress"
  security_group_id = aws_security_group.this.id
}

# Allow access to peer discovery from private subnets
resource "aws_security_group_rule" "peer_discovery" {
  cidr_blocks       = [for s in data.aws_subnet.private : s.cidr_block]
  description       = "peer-discovery-rabbit"
  from_port         = 4369
  to_port           = 4369
  protocol          = "tcp"
  type              = "ingress"
  security_group_id = aws_security_group.this.id
}

# Allow access to peer discovery from private subnets
resource "aws_security_group_rule" "peer_discovery2" {
  cidr_blocks       = [for s in data.aws_subnet.private : s.cidr_block]
  description       = "peer-discovery-rabbit"
  from_port         = 25672
  to_port           = 25672
  protocol          = "tcp"
  type              = "ingress"
  security_group_id = aws_security_group.this.id
}

# Allow access to peer discovery from private subnets
resource "aws_security_group_rule" "peer_discovery3" {
  cidr_blocks       = [for s in data.aws_subnet.private : s.cidr_block]
  description       = "peer-discovery-rabbit"
  from_port         = 35672
  to_port           = 35862
  protocol          = "tcp"
  type              = "ingress"
  security_group_id = aws_security_group.this.id
}

# Allow access from the load balancer
resource "aws_security_group_rule" "management" {
  description              = "management"
  from_port                = 15672
  to_port                  = 15672
  protocol                 = "tcp"
  type                     = "ingress"
  security_group_id        = aws_security_group.this.id
  source_security_group_id = data.aws_security_group.external.id
}

# Allow access from the load balancer
resource "aws_security_group_rule" "prometheus" {
  description              = "prometheus"
  from_port                = 15692
  to_port                  = 15692
  protocol                 = "tcp"
  type                     = "ingress"
  security_group_id        = aws_security_group.this.id
  source_security_group_id = data.aws_security_group.internal.id
}

# # Allow access from prometheus to internal lb
# resource "aws_security_group_rule" "prometheus-lb" {
#   count                    = var.setup_prometheus ? 1 : 0
#   description              = "prometheus"
#   from_port                = 15692
#   to_port                  = 15692
#   protocol                 = "tcp"
#   type                     = "ingress"
#   security_group_id        = data.aws_security_group.internal.id
#   source_security_group_id = data.aws_security_group.prometheus.id
# }
