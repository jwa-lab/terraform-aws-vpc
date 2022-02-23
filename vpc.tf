resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16" # CIDR for public subnets
  enable_dns_hostnames = true

  tags = {
    Name = local.vpc_name
  }
}
