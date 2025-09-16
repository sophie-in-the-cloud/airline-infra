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

# --------------------- EC2 Launch Template for EKS Nodes ---------------------
resource "aws_launch_template" "eks_worker_lt" {
  name_prefix = "${var.prefix}-eks-worker-lt-"
  
  # ❗️ 중요: 인스턴스 타입은 이제 여기서 정의합니다.
  instance_type = var.eks_node_instance_type

  # ✨ 여기가 핵심: 메타데이터 옵션을 설정합니다.
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  # EKS가 AMI를 자동으로 관리하도록 image_id는 비워둡니다.
  # 그 외 필요한 설정 (예: block_device_mappings 등)을 추가할 수 있습니다.

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.prefix}-eks-worker-node"
    }
  }

  lifecycle {
    create_before_destroy = true
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
  launch_template {
    id      = aws_launch_template.eks_worker_lt.id
    version = aws_launch_template.eks_worker_lt.latest_version
  }
  tags = {
    Name = "${var.prefix}-worker-ng"
  }

   depends_on = [
    aws_launch_template.eks_worker_lt
  ]
  
}
