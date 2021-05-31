resource "aws_security_group" "this" {
  name   = var.internal ? "${var.name}-internal-lb-sg" : "${var.name}-external-lb-sg"
  vpc_id = data.aws_vpc.selected.id

  # TODO This should be more restricted
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  lifecycle {
    ignore_changes        = [ingress]
    create_before_destroy = true
  }

  tags = {
    Name    = var.internal ? "${var.name}-internal-lb-sg" : "${var.name}-external-lb-sg"
    Product = var.name
  }
}

resource "aws_security_group_rule" "public" {
  count             = var.internal ? 0 : 1
  security_group_id = aws_security_group.this.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "allow-443"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
}

resource "aws_security_group_rule" "http" {
  count             = var.internal ? 0 : 1
  security_group_id = aws_security_group.this.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "allow-80-to-redirect"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
}

resource "aws_security_group_rule" "this" {
  count             = var.internal ? 1 : 0
  security_group_id = aws_security_group.this.id
  cidr_blocks       = [for s in data.aws_subnet.this : s.cidr_block]
  description       = "allow-private-subnet-access"
  type              = "ingress"
  from_port         = var.from_port
  to_port           = var.to_port
  protocol          = "tcp"
}
