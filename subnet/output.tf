output "all_subnets_ids" {
  value = local.all_subnet_ids
}

output "routing_table_ids" {
  value = {
    Private = aws_route_table.private_table.id
    Public  = length(var.public_subnets) > 0 ? aws_route_table.public_table[0].id : null
  }
}