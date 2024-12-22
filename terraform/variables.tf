variable "project_name" {
  type = any
}

variable "region" {
  type = string
}

variable "profile" {
  type = string
}

variable "env" {
  type = string
  default = "dev"
}

#VPC variables
variable "vpc_cidr" {
  description   = "vpc cidr block"
  type          = string
}

variable "public_subnets" {
  description   = "vpc public_subnets"
  type          = list(string)
}

variable "private_subnets" {
  description   = "vpc private_subnets"
  type          = list(string)
}

variable "aws_avaibility_zones" {
  description   = "aws_avaibility_zones"
  type          = list(string)
}

variable "aws_dr_avaibility_zones" {
  description   = "aws_avaibility_zones"
  type          = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
}

variable "ssh_location" {
  description   = "the ip address that can access into the ec2 instances"
  type          = string
}


#EKS variables
variable "cluster1_name" {
  description = "name of the EKS cluster"
  type = string
}

#ECR variables:
variable "ecr_name" {
  description = "Name of the ECR repo"
  type = string
}

#Codebuild variables:
variable "repository_name" {
  description = "Name of the CodeBuild repo"
  type = string
}

variable "github_repo_url" {
  description = "Endpoint of github project"
  type = string
}

variable "buildspec_path" {
  description = "value"
  type = string
}