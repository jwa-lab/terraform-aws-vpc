# Terraform AWS VPC

A Terraform module to create a VPC in AWS. It contains:

* 1 VPC
* 1 Internet Gateway
* 2 or 3 public subnets
* 2 or 3 private subnets for applications
* 2 or 3 private subnets for data
* 1 NAT Gateway per subnet with a route table allow outbound traffic

![vpc](https://user-images.githubusercontent.com/86591400/228876266-b76cb060-46ef-400d-83df-262f88cf487f.png)
