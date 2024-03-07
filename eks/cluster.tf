resource "aws_eks_cluster" "terraform" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.k8s_master_version

  enabled_cluster_log_types = ["controllerManager", "scheduler", "authenticator", "audit", "api"]

  kubernetes_network_config {
    service_ipv4_cidr       = "10.100.0.0/16"
  }

  dynamic "encryption_config" {
    for_each = length(var.encryption_config_resources) == 0 ? [] : [var.encryption_config_resources]
    content {
      resources = encryption_config.value
      provider {
        key_arn = var.encryption_kms_arn
      }
    }
  }

  vpc_config {
    subnet_ids              = var.eni_subnet_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    security_group_ids      = [aws_security_group.cluster_access.id]
  }
}

resource "aws_iam_openid_connect_provider" "cluster" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.cluster_tls_cert.certificates[0].sha1_fingerprint]
  url             = lookup(aws_eks_cluster.terraform.identity[0].oidc[0], "issuer")
}
