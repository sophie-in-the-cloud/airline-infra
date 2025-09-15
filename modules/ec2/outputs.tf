output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "bastion_key_name" {
  value = aws_key_pair.bastion_key.key_name
}

output "management_private_ip" {
  value = aws_instance.management.private_ip
}