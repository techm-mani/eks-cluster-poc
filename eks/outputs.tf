output "eks_cluster_id" {
  value = aws_eks_cluster.terraform.id
}

output "kubernetes_endpoint" {
  value = aws_eks_cluster.terraform.endpoint
}

output "cluster_name" {
  value = aws_eks_cluster.terraform.name
}

output "cluster_ca_certificate" {
  value = aws_eks_cluster.terraform.certificate_authority[0].data
}

output "cluster_arn" {
  value = aws_eks_cluster.terraform.arn
}

output "cluster_security_group" {
  value = concat([one(aws_eks_cluster.terraform.vpc_config).cluster_security_group_id], tolist(one(aws_eks_cluster.terraform.vpc_config).security_group_ids))
}

output "elb_sg" {
  value = aws_security_group.ingress_elb_to_cluster_access.id
}

output "oidc_url" {
  value = lookup(aws_eks_cluster.terraform.identity[0].oidc[0], "issuer")
}

output "oidc_arn" {
  value = aws_iam_openid_connect_provider.cluster.arn
}