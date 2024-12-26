variable "project" {
  description = "Project name"
  type = string
}

variable "env" {
  description = "Environment name"
  type = string
}

variable "vpc_cidr" {
  description = "vpc cidr block"
  type = string
}

variable "public_subnets" {
  description = "Public subnet CIDR blocks"
  type = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDR blocks"
  type = list(string)
}

variable "avaibility_zones" {
  description = "Availability zones to use"
  type = list(string)
}

variable "ssh_location" {
  description = "Allowed SSH access CIDR block"
  type = string
}