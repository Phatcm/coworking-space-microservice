resource "aws_eip" "nat" {
  count = 2
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  # The rest of arguments are omitted for brevity
  name = "${var.project}-vpc"
  cidr = var.vpc_cidr
  azs = var.avaibility_zones
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway  = true
  single_nat_gateway  = false
  reuse_nat_ips       = true                    # <= Skip creation of EIPs for the NAT Gateways
  external_nat_ip_ids = "${aws_eip.nat.*.id}"   # <= IPs specified here as input to the module

  tags = {
    Terraform = "true"
    Project = "${var.project}"
    Name = "${var.project}-vpc"
    Environment = "${var.env}"
  }
}
