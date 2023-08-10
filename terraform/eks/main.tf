data "aws_iam_role" "cluster_role" {
  name = "eksClusterRole"

}

data "aws_iam_role" "node_group_role" {
  name = "NodeInstanceRole"
}

data "aws_vpc" "main" {
  id   = var.generated_vpc_id
}

data "aws_subnet" "public_subnet1" {
  id = var.public_subnet1_id
}

data "aws_subnet" "public_subnet2" {
  id = var.public_subnet2_id
}

# Define other EKS-related resources (node groups, etc.) here...

resource "aws_security_group" "eks_security_group" {
  name        = "${var.environment_name}-EKSSecurityGroup"
  description = "EKS Cluster Security Group"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port = 5000
    to_port   = 5000
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 27017
    to_port   = 27017
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment_name
    Name        = "${var.environment_name}-EKSSecurityGroup"
  }
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "EKSCluster"
  role_arn = data.aws_iam_role.cluster_role.arn

  vpc_config {
    security_group_ids = [aws_security_group.eks_security_group.id]
    subnet_ids         = [data.aws_subnet.public_subnet1.id, data.aws_subnet.public_subnet2.id]
  }
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_role_arn  = data.aws_iam_role.node_group_role.arn
  subnet_ids     = [data.aws_subnet.public_subnet1.id, data.aws_subnet.public_subnet2.id]
  scaling_config {
    min_size = 1
    desired_size = 1
    max_size = 3
  }

  tags = {
    Environment = var.environment_name
    Name        = "${var.environment_name}-Node"
  }
}

