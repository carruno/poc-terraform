resource "aws_security_group" "this" {
  name   = "${var.app_name}-rds-endpoint-sg"
  vpc_id = data.aws_vpc.selected.id
  ingress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "TCP"
    cidr_blocks = data.aws_subnet.private.*.cidr_block
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = data.aws_subnet.private.*.cidr_block
  }
}
