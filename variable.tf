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