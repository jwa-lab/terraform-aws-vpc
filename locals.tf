locals {
  vpc_azs = slice(data.aws_availability_zones.available_azs.names, 0, var.azs_number)
}
