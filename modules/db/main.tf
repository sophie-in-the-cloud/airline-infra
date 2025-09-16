resource "aws_db_subnet_group" "this" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.db_name}-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier            = "lhs-db"
  allocated_storage    = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_name                 = var.db_name
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  publicly_accessible  = false
  skip_final_snapshot  = true
  vpc_security_group_ids = var.security_group_ids
  db_subnet_group_name   = aws_db_subnet_group.this.name
  multi_az            = false
} 