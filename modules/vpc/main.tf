locals {
  az_count = length(var.availability_zones)
  name  = replace(var.name, "-", "_")
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    { Name = upper("VPC_${local.name}") },
    var.tags
  )
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.this.id
  tags = merge(
    { Name = upper("DEFAULT_${local.name}_SG") },
    var.tags
  )
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge(
    { Name = upper("IGW_${local.name}") },
    var.tags
  )
}
