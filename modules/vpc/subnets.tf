resource "aws_subnet" "public" {
  availability_zone       = var.availability_zones[count.index]
  count                   = local.az_count
  cidr_block              = "${var.subnet_prefix}.${var.public_start_ip + count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.this.id

  tags = merge(
    {
      Name = upper("(public-${var.name}-${var.availability_zones[count.index]})")
      Tier = "Public"
    },
    var.tags
  )
}

resource "aws_subnet" "private" {
  availability_zone = var.availability_zones[count.index]
  count             = local.az_count
  cidr_block        = "${var.subnet_prefix}.${var.private_start_ip + count.index}.0/24"
  vpc_id            = aws_vpc.this.id

  tags = merge(
    {
      Name = upper("private-${var.name}-${var.availability_zones[count.index]}")
      Tier = "Private"
    },
    var.tags
  )
}
