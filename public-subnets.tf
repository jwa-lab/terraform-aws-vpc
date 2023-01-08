resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.vpc_name}-public"
  }
}

resource "aws_subnet" "public_subnets" {
  # 1 public subnet per AZ
  for_each = toset(local.vpc_azs)

  vpc_id = aws_vpc.vpc.id
  availability_zone = each.value
  map_public_ip_on_launch = true

  # 10.0.0.0/18  10.0.64.0/18  10.0.128.0/18
  # ~16k addresses per subnet
  cidr_block = join("", ["10.0.", index(local.vpc_azs, each.value)*64, ".0/18"])

  tags = {
    Name = "${var.vpc_name}-public-${each.key}"
    visibility = "public"
  }
}

resource "aws_route_table_association" "public_subnets_rta" {
  # 1 route table association per AZ/subnet
  for_each = aws_subnet.public_subnets

  subnet_id = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}
