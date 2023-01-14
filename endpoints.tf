resource "aws_vpc_endpoint" "s3" {
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_id = aws_vpc.vpc.id
  auto_accept = true

  tags = {
    Name = "${var.vpc_name}-s3"
  }
}

resource "aws_vpc_endpoint_route_table_association" "s3" {
  for_each = aws_route_table.nat_gateways_route_tables

  route_table_id  = each.value.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}
