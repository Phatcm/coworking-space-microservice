terraform {
  required_version = ">= 1.0.0"
}

locals {
  name = var.project_name
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  profile = var.profile
}
#Config K8s provider
# Get the EKS cluster details
data "aws_eks_cluster" "eks" {
  name = module.eks-cluster.cluster_name
}

data "aws_eks_cluster_auth" "eks" {
  name = data.aws_eks_cluster.eks.name
}

# Kubernetes provider to interact with the cluster
provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks-cluster.cluster_name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks-cluster.cluster_name]
      command     = "aws"
    }
  }
}

data "aws_caller_identity" "current" {}

module "vpc" {
  source = "./modules/vpc"
  project = local.name
  env = var.env
  vpc_cidr = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  avaibility_zones = var.aws_avaibility_zones
  ssh_location = var.ssh_location
}

module "eks-cluster" {
  source = "./modules/eks-cluster"
  project = local.name
  env = var.env
  cluster_name = var.cluster1_name
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "eks-nodes" {
  source = "./modules/eks-nodes"
  project = local.name
  env = var.env
  cluster_name = module.eks-cluster.cluster_name
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "iam-odic" {
  source = "./modules/iam"
  eks_issuer = module.eks-cluster.eks_issuer
}

module "ecr_repo" {
  source = "./modules/ecr"
  project = local.name
  env = var.env
  ecr_name = var.ecr_name
}

module "codebuild" {
  source = "./modules/codebuild"
  project = local.name
  env = var.env
  aws_region = var.region
  account_id = data.aws_caller_identity.current.account_id
  repository_name = var.repository_name
  github_repo_url = var.github_repo_url
  buildspec_path = var.buildspec_path

  depends_on = [
    module.ecr_repo  # Ensuring ecr_repo setup before codebuild
  ]
}

module "metrics_server" {
  source = "./modules/metrics-server"
  providers = {
    kubernetes = kubernetes
  }
  depends_on = [
    module.eks-cluster
  ]
}