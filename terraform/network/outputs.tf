output "stack_name" {
  description = "project and stack name"
  value       = aws_vpc.main.tags.Name
}

output "stack_vpc" {
  description = "A reference to the created VPC"
  value       = aws_vpc.main.id
}

output "stack_public_subnet_1" {
  description = "A reference to the created public subnet 1"
  value       = aws_subnet.public_subnet1.id
}

output "stack_public_subnet_2" {
  description = "A reference to the created public subnet 2"
  value       = aws_subnet.public_subnet2.id
}

output "stack_public_subnets" {
  description = "A list of the public subnets"
  value       = join(",", [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id])
}

output "cluster_role_arn" {
  description = "The role that Amazon EKS will use to create AWS resources for Kubernetes clusters"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "node_group_arn" {
  description = "The instance role that Amazon EKS will use to create AWS resources for Kubernetes clusters"
  value       = aws_iam_role.node_instance_role.arn
}
