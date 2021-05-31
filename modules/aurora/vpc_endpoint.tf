resource "aws_vpc_endpoint" "ep" {
  vpc_id              = data.aws_vpc.selected.id
  service_name        = data.aws_vpc_endpoint_service.rds.service_name
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.this.id]
  subnet_ids          = tolist(data.aws_subnet_ids.private.ids)
  private_dns_enabled = true
  tags = {
    Product = var.app_name
    Name    = "${var.app_name}-rds-endpoint"
  }
}
