locals {
  # Lookup Table
  # Calculated values
  all_subnet_ids = {
    eks     = [for subnet in aws_subnet.eks_subnet : lookup(subnet, "id")]
    compute = [for subnet in aws_subnet.compute_subnet : lookup(subnet, "id")]
    data    = [for subnet in aws_subnet.data_subnet : lookup(subnet, "id")]
    intra   = [for subnet in aws_subnet.intra_subnet : lookup(subnet, "id")]
    public  = [for subnet in aws_subnet.public_subnet : lookup(subnet, "id")]
    tgw     = [for subnet in aws_subnet.tgw_subnet : lookup(subnet, "id")]
  }
}
