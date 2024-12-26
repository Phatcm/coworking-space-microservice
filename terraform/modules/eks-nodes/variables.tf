variable "project" {
  description = "Project name"
  type = string
}

variable "env" {
  description = "Environment name"
  type = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type = list(string)
}