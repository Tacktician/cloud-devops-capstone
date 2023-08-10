
resource "aws_iam_role" "eks_cluster_role" {
  name = "EKSClusterRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "eks_cluster_policy" {
  name = "EKSClusterPolicy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "eks:*",
        Effect = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "eks_cluster_attachment" {
  name       = "EKSClusterAttachment"
  roles      = [aws_iam_role.eks_cluster_role.name]
  policy_arn = aws_iam_policy.eks_cluster_policy.arn
}

data "aws_partition" "current" {}

resource "aws_iam_role" "node_instance_role" {
  name = "example-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com",
          AWS = "*",
        },
      },
    ],
  })

  tags = {
    Name = "ExampleRole",
  }
}

resource "aws_iam_policy_attachment" "eks_worker_node_policy" {
  name       = "eks-worker-node-policy-attachment"
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  roles      = [aws_iam_role.node_instance_role.name]
}

resource "aws_iam_policy_attachment" "eks_cni_policy" {
  name       = "eks-cni-policy-attachment"
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonEKS_CNI_Policy"
  roles      = [aws_iam_role.node_instance_role.name]
}

resource "aws_iam_policy_attachment" "ecr_readonly_policy" {
  name       = "ecr-readonly-policy-attachment"
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  roles      = [aws_iam_role.node_instance_role.name]
}

resource "aws_iam_policy" "node_instance_policy" {
  name = "NodeInstancePolicy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "eks:DescribeCluster",
        Effect = "Allow",
        Resource = "*"
      },
      {
        Action = "ssm:GetParameter",
        Effect = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "node_instance_attachment" {
  name       = "NodeInstanceAttachment"
  roles      = [aws_iam_role.node_instance_role.name]
  policy_arn = aws_iam_policy.node_instance_policy.arn
}