terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

locals {
  prefix = "lhs"
}

module "network" {
  source          = "./modules/network"
  prefix          = local.prefix
  vpc_cidr        = var.vpc_cidr
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "sg" {
  source     = "./modules/sg"
  prefix     = local.prefix
  vpc_id     = module.network.vpc_id
  my_ip_cidr = "165.225.228.251/32"
  eks_api_sg_id = data.aws_security_group.eks_cluster_sg.id
  eks_node_sg_id = module.sg.eks_node_sg_id
}

module "ec2" {
  source            = "./modules/ec2"
  prefix            = local.prefix
  vpc_id            = module.network.vpc_id
  public_subnet_id  = module.network.public_subnet_ids[0]
  private_subnet_id = module.network.private_subnet_ids[0]
  bastion_sg_id     = module.sg.bastion_sg_id
  management_sg_id  = module.sg.management_sg_id
  bastion_ami       = "ami-02835aed2a5cb1d2a"
  management_ami    = "ami-02835aed2a5cb1d2a"
}

module "eks" {
  source             = "./modules/eks"
  prefix             = local.prefix
  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
  eks_node_instance_type = "t3.medium"
  eks_node_desired_capacity = 2
  eks_node_subnets   = [module.network.private_subnet_ids[2], module.network.private_subnet_ids[3]]
  eks_cluster_role_arn = module.iam.eks_cluster_role_arn
  eks_node_role_arn    = module.iam.eks_node_role_arn
}

module "iam" {
  source           = "./modules/iam"
  prefix           = local.prefix
}