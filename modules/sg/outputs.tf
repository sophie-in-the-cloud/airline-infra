output "bastion_sg_id" {
  value = aws_security_group.bastion.id
}

output "management_sg_id" {
  value = aws_security_group.management.id
}

output "eks_node_sg_id" {
  value = aws_security_group.eks_node_sg.id
}

output "db_sg_id" {
  value = aws_security_group.db.id
}