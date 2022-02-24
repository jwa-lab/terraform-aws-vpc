output "vpc_id" {
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
