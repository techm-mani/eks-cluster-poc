## Required fields

variable "vpc_id" {
  type        = string
  description = "the vpc to add the subnets to, not default as is REQUIRED"
  default = "vpc-077d28cff03aaaed8"
}

variable "subnet_tags" {
  type        = map(string)
  default     = {}
  description = "tags to put on all subnets, defaults to {}"
}

variable "availability_zone_id" {
  type        = list(string)
  description = "list of azs ids for the subnet ciders in the order they are in this var, defaults to null"
  default = ["aps1-az1", "aps1-az2", "aps1-az3"]
}


variable "intra_subnets" {
  type        = list(string)
  description = "cidr blocks for intranet subnets in az order for VPC2.0, default []"
  default = ["10.18.209.0/27", "10.18.209.32/27"]
}

variable "public_subnets" {
  type        = list(string)
  description = "cidr blocks for public subnets in az order for VPC2.0, default []"
  default = ["100.65.6.64/27", "100.65.6.96/27"]
}

variable "compute_subnets" {
  type        = list(string)
  description = "cidr blocks for compute subnets in az order for VPC2.0, default []"
  default = ["100.65.8.0/22", "100.65.12.0/22"]
}

variable "data_subnets" {
  type        = list(string)
  description = "cidr blocks for data subnets in az order for VPC2.0, default []"
  default = ["100.67.0.128/26", "100.67.0.192/26"]
}

variable "eks_subnets" {
  type        = list(string)
  description = "cidr blocks for eks subnets in az order for VPC2.0, default []"
  default = ["100.65.66.160/28", "100.65.66.176/28"]

}

variable "tgw_subnets" {
  type        = list(string)
  description = "cidr blocks for tgw subnets in az order for VPC2.0, default []"
  default = ["100.65.66.128/28", "100.65.66.144/28"]
}

variable "igw_id" {
  type        = string
  description = "Internet gateway id to use for public routes when not creating an igw for vpc1.0 vpcs. Default null aka no public subnets"
  default = "igw-08c3dd8bd0e7af334"
}
