output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "management_private_ip" {
  value = aws_instance.management.private_ip
}