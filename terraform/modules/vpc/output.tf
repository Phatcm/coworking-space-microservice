output "vpc_id" {
  description = "The ID of the VPC"
  value = module.vpc.vpc_id
}

output "vpc" {
  description = "The VPC object"
  value = module.vpc
}

output "public_subnet_ids" {
  description = "The public subnets"
  value = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "The private subnets"
  value = module.vpc.private_subnets
}
