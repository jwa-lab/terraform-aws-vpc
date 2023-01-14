output "vpc_id" {
  /**
   * Consumers of the VPC module may read the subnets by using the "aws_subnets" data provider, based on the VPC id.
   * With the "depends_on" instruction, we can make sure the subnets are available when the id is exported.
   */
  depends_on = [
    aws_route_table.nat_gateways_route_tables,
    aws_route_table_association.public_subnets_rta,
    aws_route_table_association.apps_subnets_rta,
    aws_route_table_association.data_subnets_rta,
    aws_vpc_endpoint_route_table_association.s3
  ]

  value = aws_vpc.vpc.id
}

output "public_subnets_ids" {
  value = [for subnet in aws_subnet.public_subnets : subnet.id]
}

output "apps_subnets_ids" {
  value = [for subnet in aws_subnet.apps_subnets : subnet.id]
}

output "data_subnets_ids" {
  value = [for subnet in aws_subnet.data_subnets : subnet.id]
}
