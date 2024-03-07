#
# Make a subnet for each eks subnet with correct tagging
#

resource "aws_subnet" "intra_subnet" {
  count                   = length(var.intra_subnets)
  cidr_block              = element(var.intra_subnets, count.index)
  vpc_id                  = var.vpc_id
  map_public_ip_on_launch = false
  availability_zone_id    = var.availability_zone_id[count.index]

  tags = merge(
    var.subnet_tags,
    { "Name" : join("-", ["intra", var.availability_zone_id[count.index]]) }
  )

  lifecycle {
    ignore_changes = [tags, tags_all]
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnets)
  cidr_block              = element(var.public_subnets, count.index)
  vpc_id                  = var.vpc_id
  map_public_ip_on_launch = true
  availability_zone_id    = var.availability_zone_id[count.index]

  tags = merge(
    var.subnet_tags,
    { "Name" : join("-", ["public", var.availability_zone_id[count.index]]) }
  )

  lifecycle {
    ignore_changes = [tags, tags_all]
  }
}

resource "aws_subnet" "compute_subnet" {
  count                   = length(var.compute_subnets)
  cidr_block              = element(var.compute_subnets, count.index)
  vpc_id                  = var.vpc_id
  map_public_ip_on_launch = false
  availability_zone_id    = var.availability_zone_id[count.index]

  tags = merge(
    var.subnet_tags,
    { "Name" : join("-", ["compute", var.availability_zone_id[count.index]]) }
  )

  lifecycle {
    ignore_changes = [tags, tags_all]
  }
}

resource "aws_subnet" "data_subnet" {
  count                   = length(var.data_subnets)
  cidr_block              = element(var.data_subnets, count.index)
  vpc_id                  = var.vpc_id
  map_public_ip_on_launch = false
  availability_zone_id    = var.availability_zone_id[count.index]

  tags = merge(
    var.subnet_tags,
    { "Name" : join("-", ["data", var.availability_zone_id[count.index]]) }
  )

  lifecycle {
    ignore_changes = [tags, tags_all]
  }
}

resource "aws_subnet" "eks_subnet" {
  count                   = length(var.eks_subnets)
  cidr_block              = element(var.eks_subnets, count.index)
  vpc_id                  = var.vpc_id
  map_public_ip_on_launch = false
  availability_zone_id    = var.availability_zone_id[count.index]

  tags = merge(
    var.subnet_tags,
    { "Name" : join("-", ["eks", var.availability_zone_id[count.index]]) }
  )

  lifecycle {
    ignore_changes = [tags, tags_all]
  }
}

resource "aws_subnet" "tgw_subnet" {
  count                   = length(var.tgw_subnets)
  cidr_block              = element(var.tgw_subnets, count.index)
  vpc_id                  = var.vpc_id
  map_public_ip_on_launch = false
  availability_zone_id    = var.availability_zone_id[count.index]

  tags = merge(
    var.subnet_tags,
    { "Name" : join("-", ["tgw", var.availability_zone_id[count.index]]) }
  )

  lifecycle {
    ignore_changes = [tags, tags_all]
  }
}