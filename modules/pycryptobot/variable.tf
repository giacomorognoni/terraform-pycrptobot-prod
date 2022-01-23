variable "desired_count" {
  type        = number
  default     = 1
  description = "The desired task count for the ecs service"
}

variable "name" {
  type        = string
  description = "The name of the project"
}

variable "environment" {
  type        = string
  default     = "prod"
  description = "The environment for the project"
}

variable "vpc_id" {
  type        = string
  description = "The id of teh VPC"
}

variable "subnets" {
  type        = list(any)
  description = "the list of private subnets for the ecs task"
}

variable "aws_alb_target_group_arn" {
  type        = string
  description = "The aws alb target group arn"
}

variable "aws_alb_security_group" {
  type        = string
  description = "aws alb security group id"
}
