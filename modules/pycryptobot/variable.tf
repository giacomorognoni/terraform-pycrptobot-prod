variable "desired_count" {
  type        = number
  default     = 1
  description = "The desired task count for the ecs service"
}

variable "name" {
  type        = string
  description = "The name of the project"
}