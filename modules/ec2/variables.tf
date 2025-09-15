variable "prefix" {}
variable "vpc_id" {}
variable "public_subnet_id" {}
variable "private_subnet_id" {}
variable "bastion_sg_id" {}
variable "management_sg_id" {}
variable "bastion_ami" {}
variable "management_ami" {}
variable "bastion_instance_type" { default = "t2.micro" }
variable "management_instance_type" { default = "t3.medium" }
