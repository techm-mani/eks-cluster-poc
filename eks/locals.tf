locals {
  ## Standard Values
  #
  # ( None Currently )

  ## Calculated Values
  #
  cluster_access_security_groups_map = {for x in var.cluster_access_security_groups: join("-", ["cluster_access_security_groups", x]) => x}
  cluster_additional_access_cidrs_map = {for x  in var.cluster_access_additional_cidrs: x => "Additional Cidrs to Access Cluster"}
  cluster_shared_access_cidrs_map = {for x  in var.cluster_access_shared_cidrs: x => "Shared Account and Shared Cluster Access"}
  cluster_access_cidrs_map = merge(local.cluster_shared_access_cidrs_map, local.cluster_additional_access_cidrs_map)

  # Cluster access sg generated during EKS creation
  #

  sg_eks_cluster_access_name = concat([one(aws_eks_cluster.terraform.vpc_config).cluster_security_group_id], tolist(one(aws_eks_cluster.terraform.vpc_config).security_group_ids))[0]
}
