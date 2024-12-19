output "vpc_id" {
  description = "The ID of the VPC"
  value = module.vpc.vpc_id
}

output "vpc" {
  description = "The VPC object"
  value = module.vpc
}

output "gateway_id" {
  description = "The ID of the internet gateway"
  value = module.vpc.internet_gateway_id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value = module.vpc.public_subnets.id
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value = module.vpc.private_subnets.id
}

output "public_subnet_ids" {
  description = "The public subnets"
  value = module.vpc.public_subnets.*.id
}

output "private_subnet_ids" {
  description = "The private subnets"
  value = module.vpc.private_subnets.*.id
}
