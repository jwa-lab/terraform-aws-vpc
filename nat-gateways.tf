resource "aws_eip" "public_subnets_ips" {
  # 1 ip per AZ/subnet
  for_each = aws_subnet.public_subnets

  vpc = true

  tags = {
    Name = "${local.vpc_name}-${each.key}"
  }

  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_nat_gateway" "nat_gateways" {
  # 1 NAT gateway per AZ in each public subnets
  for_each = aws_subnet.public_subnets

  subnet_id = each.value.id
  allocation_id = aws_eip.public_subnets_ips[each.key].id

  tags = {
    Name = "${local.vpc_name}-${each.key}"
  }

  depends_on = [aws_eip.public_subnets_ips]
}

resource "aws_route_table" "nat_gw_route_tables" {
  # 1 private route table per AZ associated with each NAT gateways
  for_each = toset(local.vpc_azs)

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateways[each.value].id
  }

  tags = {
    Name = "${local.vpc_name}-private-${each.value}"
    target = "nat-gw"
  }
}
