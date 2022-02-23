variable "vpc_name" {
  type = string
  description = "Name of the VPC"
}

variable "azs_number" {
  type = number
  description = "Number of AWS Availability Zones to use"

  validation {
    condition = var.azs_number >= 2
    error_message = "You must deploy in at least 2 availability zones."
  }

  validation {
    condition = var.azs_number <= 3
    error_message = "You cannot deploy in more than 3 availability zones."
  }
}
