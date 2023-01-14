data "aws_availability_zones" "available_azs" {
  state = "available"
}

data "aws_region" "current" {}
