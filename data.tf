data "aws_security_group" "eks_cluster_sg" {
  filter {
    name   = "tag:aws:eks:cluster-name"
    values = [module.eks.cluster_name]
  }
}