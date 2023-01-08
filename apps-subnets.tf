resource "aws_vpc_ipv4_cidr_block_association" "apps_cidr" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.2.0.0/16"
}

resource "aws_subnet" "apps_subnets" {
  # 1 private apps subnet per AZ
  for_each = toset(local.vpc_azs)

  vpc_id = aws_vpc.vpc.id

  # 10.2.0.0/18  10.2.64.0/18  10.2.128.0/18
  cidr_block = join("", ["10.2.", index(local.vpc_azs, each.value)*64, ".0/18"])
  availability_zone = each.value

  tags = {
    Name = "${var.vpc_name}-apps-${each.value}"
    visibility = "private"
    target = "apps"
  }

  depends_on = [aws_vpc_ipv4_cidr_block_association.apps_cidr]
}

resource "aws_route_table_association" "apps_subnets_rta" {
  # 1 route table association per private apps subnet
  for_each = aws_subnet.apps_subnets

  subnet_id = each.value.id
  route_table_id = aws_route_table.nat_gateways_route_tables[each.key].id
}
