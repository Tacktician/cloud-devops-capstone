variable "environment_name" {
  description = "An environment prefix for all resource names"
  type        = string
  default     = "capstone-project"
}

variable "node_group_arn" {
  description = "generated node group from network"
  type        = string
}

variable "cluster_role_arn" {
  description = "generated cluster group from network"
  type        = string
}

variable "generated_vpc_id" {
  description = "generated VPC ID from network"
  type        = string
}

variable "public_subnet1_id" {
  description = "generated public_subnet1 id"
  type        = string
}

variable "public_subnet2_id" {
  description = "generated public_subnet2 id"
  type        = string
}
