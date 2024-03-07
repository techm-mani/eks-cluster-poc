data "tls_certificate" "cluster_tls_cert" {
  url          = lookup(aws_eks_cluster.terraform.identity[0].oidc[0], "issuer")
  verify_chain = true
}