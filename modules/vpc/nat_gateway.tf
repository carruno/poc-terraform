resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.this]

  tags = merge(
    {
      Name = "${var.name}-eip"

    },
    var.tags,
  )
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public.*.id, 0)
  depends_on    = [aws_internet_gateway.this]

  tags = merge(
    { Name = "${var.name}_NAT_GATEWAY" },
    var.tags
  )
}
