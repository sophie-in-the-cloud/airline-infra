resource "aws_eks_cluster" "cluster" {
    name = "${var.prefix}-eks"
    role_arn = var.eks_cluster_role_arn
    vpc_config {
        subnet_ids = var.private_subnet_ids
    }

    tags = {
        Name = "${var.prefix}-eks-cluster"
    }
}
# --------------------- Managed Node Group ---------------------
resource "aws_eks_node_group" "worker" {
    cluster_name = aws_eks_cluster.cluster.name
    node_group_name = "${var.prefix}-worker-ng"
    node_role_arn = var.eks_node_role_arn
    subnet_ids = var.eks_node_subnets

    scaling_config {
        desired_size = var.eks_node_desired_capacity
        min_size     = 1
        max_size     = 3
  }
  instance_types = [var.eks_node_instance_type]

  tags = {
    Name = "${var.prefix}-worker-ng"
  }
}
