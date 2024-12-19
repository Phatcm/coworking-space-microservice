project_name = "terraform_aws"
region = "ap-northeast-1"
profile = "phatcao-dev"
env = "dev"

#primary_region_vpc
vpc_cidr = "10.0.0.0/16"
public_subnets        = ["10.0.1.0/19", "10.0.2.0/19"]
private_subnets         = ["10.0.3.0/24", "10.0.4.0/24"]
aws_avaibility_zones = ["ap-northeast-1a", "ap-northeast-1c"]
ssh_location = "0.0.0.0/0"