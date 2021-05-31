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
  }
}

# Allow access from the private subnets
resource "aws_security_group_rule" "this" {
  security_group_id = aws_security_group.this.id
  cidr_blocks       = data.aws_subnet.private.*.cidr_block
  description       = "private subnet"
  from_port         = 5672
  to_port           = 5672
  protocol          = "tcp"
  type              = "ingress"
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
  source_security_group_id = data.aws_security_group.external.id
}

# Setup port on internal lb
resource "aws_security_group_rule" "lb_prometheus" {
  description       = "prometheus-rabbit"
  cidr_blocks       = data.aws_subnet.private.*.cidr_block
  from_port         = 15692
  to_port           = 15692
  protocol          = "tcp"
  type              = "ingress"
  security_group_id = data.aws_security_group.internal.id
}
