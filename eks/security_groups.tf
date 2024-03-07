resource "aws_security_group" "cluster_access" {
  name   = format("%s-cluster-access-sg", var.cluster_name)
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "cluster_access_sgs" {
  for_each = local.cluster_access_security_groups_map
  from_port                = 0
  protocol                 = "tcp"
  security_group_id        = aws_security_group.cluster_access.id
  to_port                  = 65535
  type                     = "ingress"
  source_security_group_id = each.value
}

resource "aws_security_group_rule" "allows_cidrs" {
  for_each = local.cluster_access_cidrs_map
  from_port         = 0
  protocol          = "tcp"
  security_group_id = aws_security_group.cluster_access.id
  to_port           = 65535
  type              = "ingress"
  cidr_blocks       = [each.key]
  description       = each.value
}


resource "aws_security_group_rule" "egress" {
  from_port         = 0
  protocol          = "all"
  security_group_id = aws_security_group.cluster_access.id
  to_port           = 65535
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "ingress_elb_to_cluster_access" {
  name   = "${var.cluster_name}-ingress-elb-to-eks-cluster-access"
  vpc_id = var.vpc_id
}

resource "aws_ec2_tag" "ingress_sg" {
  key         = "transpiler.io/security_group/${var.cluster_name}"
  resource_id = aws_security_group.ingress_elb_to_cluster_access.id
  value       = "ingress"
}

resource "aws_security_group_rule" "ingress_elb_to_cluster_access_http" {
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.ingress_elb_to_cluster_access.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_elb_to_cluster_access_https" {
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.ingress_elb_to_cluster_access.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_elb_to_cluster_egress" {
  from_port         = 0
  protocol          = "tcp"
  security_group_id = aws_security_group.ingress_elb_to_cluster_access.id
  to_port           = 65535
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "cluster_access_rules" {
  for_each                 = local.cluster_access_security_groups_map
  from_port                = 0
  protocol                 = "tcp"
  security_group_id        = aws_eks_cluster.terraform.vpc_config[0].cluster_security_group_id
  to_port                  = 65535
  type                     = "ingress"
  source_security_group_id = each.value
}

resource "aws_security_group_rule" "ingress_elb_access_to_eks_cluster" {
  from_port         = 0
  protocol          = "all"
  security_group_id = local.sg_eks_cluster_access_name
  to_port           = 65535
  type              = "ingress"
  source_security_group_id = aws_security_group.ingress_elb_to_cluster_access.id
}

