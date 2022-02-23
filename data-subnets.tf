resource "aws_vpc_ipv4_cidr_block_association" "data_cidr" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.1.0.0/16"
}

resource "aws_subnet" "data_subnets" {
  # 1 private data subnet per AZ
  for_each = toset(local.vpc_azs)

  vpc_id = aws_vpc.vpc.id

  # 10.1.0.0/18  10.1.64.0/18  10.1.128.0/18
  cidr_block = join("", ["10.1.", index(local.vpc_azs, each.value)*64, ".0/18"])
  availability_zone = each.value

  tags = {
    Name = "${local.vpc_name}-data-${each.value}"
    visibility = "private"
    target = "data"
  }

  depends_on = [aws_vpc_ipv4_cidr_block_association.data_cidr]
}

resource "aws_route_table_association" "data_subnets_rta" {
  # 1 route table association per private data subnet
  for_each = aws_subnet.data_subnets

  subnet_id = each.value.id
  route_table_id = aws_route_table.nat_gw_route_tables[each.key].id
}
