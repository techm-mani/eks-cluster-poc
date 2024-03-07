variable "cluster_access_security_groups" {
  type        = list(string)
  description = "source security groups to allow access to the cluster, required"
}

variable "cluster_access_shared_cidrs" {
  type        = list(string)
  default     = ["10.18.48.0/20", "100.66.0.0/17"]
  description = "source cidr blocks to allow access to the cluster from shared, defaults to [\"10.18.48.0/20\", \"100.66.0.0/17\"] for [consul, openvpn, udp]"
}

variable "cluster_access_open_vpn_pl" {
  type = string
  default = "pl-03c3171e54b08545f"
  description = "the source pl to allow access to the cluster over open vpn, defaults to pl-03c3171e54b08545f"
}

variable "cluster_access_additional_cidrs" {
  type = list(string)
  default = []
  description = "additional cidrs allow access to the cluster over open vpn, defaults to []"
}

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster to create, required"
  default = "mani-demo"
}

variable "cluster_role_arn" {
  type = string
  description = "The role arn of the cluster role, required"
}

variable "encryption_config_resources" {
  type        = list(string)
  default     = ["secrets"]
  description = "the K8s resources to encrypt in the etcd, defaults to [\"secrets\"]"
}

variable "encryption_kms_arn" {
  type        = string
  description = "the KMS key to use to encrypt the etcd volumes, required"
}

variable "endpoint_private_access" {
  type        = string
  default     = true
  description = "set API endpoint to private, standard is true, defaults to true"
}

variable "endpoint_public_access" {
  type        = string
  default     = false
  description = "set the API endpoint to public, standard is false, defaults to false"
}

variable "k8s_master_version" {
  type        = string
  description = "the k8s master version to use aka control plane version, required"
}

variable "eni_subnet_ids" {
  type        = list(string)
  description = "The eks subnets for the eni's to reside on, required"
}

variable "vpc_id" {
  type        = string
  description = "The id of the VPC to create the EKS cluster in, required"
  default = "vpc-077d28cff03aaaed8"
}




