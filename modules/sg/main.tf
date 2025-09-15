
resource "aws_security_group" "bastion" {
  name   = "${var.prefix}-bastion-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.prefix}-bastion-sg" }
}

# Management SG
resource "aws_security_group" "management" {
  name   = "${var.prefix}-management-sg"
  vpc_id = var.vpc_id

  ingress {
    description     = "SSH from Bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  ingress {
    description     = "control plane"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [var.eks_api_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.prefix}-management-sg" }
}

resource "aws_security_group" "eks_node_sg" {
  name        = "${var.prefix}-eks-node-sg"
  description = "Security group for EKS Node Group"
  vpc_id      = var.vpc_id

 ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.management.id]
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    self            = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-eks-node-sg"
  }
}