project_name = "terraform_aws"
region = "us-east-1"
profile = "default"
env = "dev"

#primary_region_vpc
vpc_cidr = "10.0.0.0/16"
public_subnets = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnets = ["10.0.2.0/24", "10.0.3.0/24"]
aws_avaibility_zones = ["us-east-1a", "us-east-1b"]
ssh_location = "0.0.0.0/0"
cluster1_name = "terraform-cluster-1"