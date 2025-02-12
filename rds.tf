# rds.tf
resource "aws_db_subnet_group" "main" {
  name        = "rds-subnet-group"
  description = "RDS subnet group"
  subnet_ids  = [aws_subnet.private_1.id, aws_subnet.private_2.id]

  tags = {
    Environment = var.environment
  }
}

resource "aws_db_instance" "main" {
  identifier           = "rds-${var.environment}"
  engine              = "mysql"
  engine_version      = "8.4.3"
  instance_class      = var.instance_class
  allocated_storage   = var.allocated_storage
  storage_type        = "gp2"
  
  db_name             = var.database_name
  username            = var.database_username
  password            = var.database_password
  
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  
  skip_final_snapshot    = true
  
  # Enable CloudWatch Logs export
  enabled_cloudwatch_logs_exports = [
    "audit",
    "error",
    "general",
    "slowquery"
  ]
  
  # Enable automated backups
  backup_retention_period = 7
  
  # Enable encryption
  storage_encrypted = true
  
  tags = {
    Name        = "rds-${var.environment}"
    Environment = var.environment
  }
}
