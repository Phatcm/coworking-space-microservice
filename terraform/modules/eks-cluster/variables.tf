variable "project" {
  description = "Project name"
  type = string
}

variable "env" {
  description = "Environment name"
  type = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "cluster_version" {
  description = "The version of the EKS cluster."
  type = string
  default = "1.21"
}

variable "vpc_id" {
  type = string
  description = "The ID of the VPC where the EKS cluster will be deployed."
}

variable "public_subnet_ids" {
  type = list(string)
  description = "The public subnet IDs to use for the EKS cluster."
}

variable "private_subnet_ids" {
  type = list(string)
  description = "The private subnet IDs to use for the EKS cluster."
}