output "cluster_name" {
  value = aws_eks_cluster.demo.name
}

output "eks_issuer" {
  value = aws_eks_cluster.demo.identity[0].oidc[0].issuer
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.demo.endpoint
}

output "eks_cluster_certificate_authority" {
  value = aws_eks_cluster.demo.certificate_authority[0].data
}
