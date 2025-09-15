variable "prefix" {}
variable "vpc_id" {}
variable "private_subnet_ids" { type = list(string) }
variable "eks_node_instance_type" { default = "t3.medium" }
variable "eks_node_desired_capacity" { default = 2 }
variable "eks_node_subnets" { type = list(string) }
variable "eks_cluster_role_arn" {}
variable "eks_node_role_arn" {}