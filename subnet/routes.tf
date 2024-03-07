resource "aws_route_table" "public_table" {
  count  = length(var.public_subnets) > 0 ? 1 : 0
  vpc_id = var.vpc_id
  tags   = { Name = "Public" }
}

resource "aws_route" "public_internet" {
  count                  = length(var.public_subnets) > 0 ? 1 : 0
  route_table_id         = aws_route_table.public_table[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}

resource "aws_route_table" "private_table" {
  vpc_id = var.vpc_id
  tags   = { Name = "Private" }
}

resource "aws_route" "private_internet" {
  route_table_id         = aws_route_table.private_table.id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = "tgw-00f76112ccc9ad939"
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  route_table_id = aws_route_table.public_table[0].id
  subnet_id      = aws_subnet.public_subnet[count.index].id
}

resource "aws_route_table_association" "compute" {
  count          = length(var.compute_subnets)
  route_table_id = aws_route_table.private_table.id
  subnet_id      = aws_subnet.compute_subnet[count.index].id
}

resource "aws_route_table_association" "eks" {
  count          = length(var.eks_subnets)
  route_table_id = aws_route_table.private_table.id
  subnet_id      = aws_subnet.eks_subnet[count.index].id
}

resource "aws_route_table_association" "intra" {
  count          = length(var.intra_subnets)
  route_table_id = aws_route_table.private_table.id
  subnet_id      = aws_subnet.intra_subnet[count.index].id
}

resource "aws_route_table_association" "data" {
  count          = length(var.data_subnets)
  route_table_id = aws_route_table.private_table.id
  subnet_id      = aws_subnet.data_subnet[count.index].id
}

resource "aws_route_table_association" "tgw" {
  count          = length(var.tgw_subnets)
  route_table_id = aws_route_table.private_table.id
  subnet_id      = aws_subnet.tgw_subnet[count.index].id
}