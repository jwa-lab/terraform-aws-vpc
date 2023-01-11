output "vpc_id" {
  /**
   * Consumers of the VPC module may read the subnets by using the "aws_subnets" data provider, based on the VPC id.
   * With the "depends_on" instruction, we can make sure the subnets are available when the id is exported.
   */
  depends_on = [
    aws_subnet.public_subnets,
    aws_subnet.apps_subnets,
    aws_subnet.data_subnets,
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
