resource "aws_iam_role" "eks-nodes-role" {
  name = "eks-node-group-data-plane-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "data-plane-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-nodes-role.name
}

resource "aws_iam_role_policy_attachment" "data-plane-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-nodes-role.name
}

resource "aws_iam_role_policy_attachment" "data-plane-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-nodes-role.name
}

resource "aws_launch_template" "nodes" {
  vpc_security_group_ids = [aws_security_group.EKS-NODE-SG.id]
  key_name = ""
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = "${var.EKSNODEVSIZE}"
      delete_on_termination = "true"
      volume_type = "gp2"
    }
  }
  instance_type = "${var.EKSNODETYPE}"
  tag_specifications {
    resource_type = "instance"
    tags = {
      "Name" = "${var.PROJECT}-${var.VPCNAME}-${var.ENV}"
      "kubernetes.io/cluster/${aws_eks_cluster.eks-cluster.name}" = "shared"
    }
  }  
}

resource "aws_eks_node_group" "eks-nodes" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "${var.PROJECT}-${var.VPCNAME}-${var.ENV}"
  node_role_arn   = aws_iam_role.eks-nodes-role.arn
  subnet_ids      = [aws_subnet.public-subnet1.id,aws_subnet.public-subnet2.id,aws_subnet.public-subnet3.id]

  tags = {
    Name = "${var.PROJECT}-${var.VPCNAME}-${var.ENV}"
  }
  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.data-plane-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.data-plane-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.data-plane-AmazonEC2ContainerRegistryReadOnly,
  ]
}
