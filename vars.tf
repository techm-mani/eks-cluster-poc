variable "cidr_block" {
  type        = string
  description = "REQUIRED: the main cidr block for the vpc."
}

variable "enable_dns_support" {
  type        = bool
  description = "A boolean flag to enable/disable DNS support in the VPC. Defaults true."
  default     = true
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
  default     = false
}

variable "vpc_name" {
  type        = string
  description = "REQUIRED: name of vpc."
}

variable "igw_name" {
  type        = string
  description = "Name of igw. Necessary for legacy accounts, DEFAULTS to var.vpc_name"
}

variable "additional_cidr_blocks" {
  type        = list(string)
  default     = ["100.65.6.64/26", "100.65.8.0/21", "100.67.0.128/25", "100.65.66.128/26"]
  description = "Additional IPv4 cidr blocks to associate to the vpc, defaults to null"
}

variable "vpc_tags" {
  type        = map(string)
  default     = null
  description = "Additional tags for the VPC, defaults to null"
}