resource "aws_ecr_repository" "ecr" {
  name = var.ecr_name

  tags = {
    Terraform = "true"
    Project = "${var.project}"
    Name = "${var.project}-vpc"
    Environment = "${var.env}"
  }
}

