resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge({ Name = var.vpc_name }, var.vpc_tags)

  lifecycle {
    ignore_changes = [
      tags, tags_all
    ]
  }
}

resource "aws_default_security_group" "cleanse" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name       = "default - DO NOT USE THIS!",
    DO_NOT_USE = "ABSOLUTELY NEVER USE!"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = var.igw_name }
}

resource "aws_vpc_ipv4_cidr_block_association" "additional_cidrs" {
  for_each   = toset(var.additional_cidr_blocks)
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value
}