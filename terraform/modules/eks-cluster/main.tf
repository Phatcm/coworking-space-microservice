#IAM role for EKS cluster
resource "aws_iam_role" "demo" {
  name = "eks_cluster_demo"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

#Add EKS cluster policy to the iam role
resource "aws_iam_role_policy_attachment" "demo-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.demo.name
}

resource "aws_iam_role_policy_attachment" "demo-AmazonEKSBlockStoragePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSBlockStoragePolicy"
  role = aws_iam_role.demo.name
}

resource "aws_iam_role_policy_attachment" "demo-AmazonEKSComputePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSComputePolicy"
  role = aws_iam_role.demo.name
}

resource "aws_iam_role_policy_attachment" "demo-AmazonEKSLoadBalancingPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy"
  role = aws_iam_role.demo.name
}

resource "aws_iam_role_policy_attachment" "demo-AmazonEKSNetworkingPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSNetworkingPolicy"
  role = aws_iam_role.demo.name
}

#Create EKS cluster
resource "aws_eks_cluster" "demo" {
  name = var.cluster_name
  role_arn = aws_iam_role.demo.arn
  vpc_config {
    subnet_ids = concat(
      var.public_subnet_ids,
      var.private_subnet_ids
    )
  }
  tags = {
    Terraform = "true"
    Project = "${var.project}"
    Name = "${var.project}-vpc"
    Environment = "${var.env}"
  }
  depends_on = [aws_iam_role_policy_attachment.demo-AmazonEKSClusterPolicy]
}

#Cloudwatch container insight addon
resource "aws_eks_addon" "cloudwatch_observability" {
  cluster_name =  aws_eks_cluster.demo.name
  addon_name   = "amazon-cloudwatch-observability"
  addon_version = "v2.6.0-eksbuild.1" 
  resolve_conflicts_on_create  = "OVERWRITE"

  tags = {
    Terraform = "true"
    Project = "${var.project}"
    Name = "${var.project}-vpc"
    Environment = "${var.env}"
  }
}