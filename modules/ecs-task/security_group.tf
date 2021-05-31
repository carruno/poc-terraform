resource "aws_security_group" "this" {
    name        = "${var.app_name}-${var.container_name}-sg"
    vpc_id      = data.aws_vpc.selected.id

    # TODO This should be more restricted
    egress {
      cidr_blocks = ["0.0.0.0/0"]
      description = "internet"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
    }

    tags = {
      Name = "${var.app_name}-${var.container_name}-sg"
      Product = var.app_name
    }
}

resource "aws_security_group_rule" "subnet" {
  security_group_id = aws_security_group.this.id
  cidr_blocks = data.aws_subnet.private.*.cidr_block
  description = "private subnet"
  from_port = var.container_port
  to_port = var.container_port
  type = "ingress"
  protocol = "tcp"
}

resource "aws_security_group_rule" "load_balancer" {
  security_group_id = data.aws_security_group.selected.id
  description = "allow load balancer to ${var.container_name}"
  from_port = var.container_port
  to_port = var.container_port
  protocol = "tcp"
  type = "ingress"
  source_security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "public" {
  security_group_id = aws_security_group.this.id
  count = var.allow_public_access ? 1 : 0
  cidr_blocks = ["0.0.0.0/0"]
  description = "${var.container_name}-public"
  type = "ingress"
  from_port = var.container_port
  to_port = var.container_port
  protocol = "tcp"
}
