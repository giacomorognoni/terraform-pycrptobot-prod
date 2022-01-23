variable "AWS_REGION" {
  type        = string
  default     = "eu-west-2"
  description = "AWS region for the pycryptobot production service"
}

variable "desired_count" {
  type        = number
  default     = 1
  description = "The desired task count for the ecs service"
}

variable "name" {
  type        = string
  description = "The name of the project"
}

variable "cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Largest possible cidr block range 10.0.0.0 -> 10.255.255.255"
}

variable "private_subnets" {
  type        = list(any)
  default     = ["10.0.1.0/24"]
  description = "the cidr range for the private subnet"
}

variable "public_subnets" {
  type        = list(any)
  default     = ["10.0.0.0/24"]
  description = "the cidr range for the public subnet"
}


variable "az_count" {
  type        = number
  description = "Number of availability zones for region"
  default     = 1
}

variable "availability_zones" {
  type        = list(any)
  description = "The availability zones for the environment. Examples: eu-west-1a, eu-west-1b"
  default     = ["eu-west-2a"]
}

variable "subnet_spacing" {
  type        = number
  default     = 1
  description = "Number to use to space out the gaps between subnets, if your using 3 AZs, we recommend setting this to 1"
}

variable "num_nat_gateways" {
  type        = number
  default     = 1
  description = "The number of NAT Gateways required for the environment. For dev and test this should not be more than 1. For Production, this should equal the number of availability zones. Only appliable for VPCs with an internet gateway"
}

variable "environment" {
  type        = string
  default     = "prod"
  description = "The environment for the project"
}
