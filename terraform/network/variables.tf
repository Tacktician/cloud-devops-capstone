variable "environment_name" {
  description = "An environment prefix for all resource names"
  type        = string
  default     = "capstone-project-terraform"
}

variable "vpc_cidr" {
  description = "IP range (CIDR notation) for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet1_cidr" {
  description = "IP range (CIDR notation) for public subnet 1"
  type        = string
  default     = "10.0.0.0/24"
}

variable "subnet2_cidr" {
  description = "IP range (CIDR notation) for public subnet 2"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = [  "us-west-2a",  "us-west-2b",  "us-west-2c"]
}