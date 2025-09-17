resource "aws_key_pair" "bastion_key" {
  key_name   = "lhs-bastion-key"
  public_key = file("C:/Users/임효선HyosunLim/.ssh/lhs-bastion-key.pub")
}

resource "aws_instance" "bastion" {
  ami                    = var.bastion_ami
  instance_type          = var.bastion_instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.bastion_sg_id]
  key_name               = aws_key_pair.bastion_key.key_name
  tags = {
    Name = "${var.prefix}-bastion"
  }
}

resource "aws_instance" "management" {
  ami                    = var.management_ami
  instance_type          = var.management_instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.management_sg_id]
  key_name               = aws_key_pair.bastion_key.key_name
  tags = {
    Name = "${var.prefix}-management"
  }
}

resource "aws_instance" "qdev" {
  ami                    = var.management_ami
  instance_type          = var.management_instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.management_sg_id]
  key_name               = aws_key_pair.bastion_key.key_name
  tags = {
    Name = "${var.prefix}-qdev"
  }
}
