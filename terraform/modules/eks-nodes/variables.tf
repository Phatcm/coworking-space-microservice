variable "project" {
  description = "Project name"
  type = string
}

variable "env" {
  description = "Environment name"
  type = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type = list(string)
}