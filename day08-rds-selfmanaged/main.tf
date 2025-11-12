#######################################
# IAM Role for Enhanced Monitoring
#######################################
resource "aws_iam_role" "rds_monitoring" {
  name = "rds-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "monitoring.rds.amazonaws.com"
      }
    }]
  })
}

# Attach AWS-managed policy for RDS monitoring
resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
  role       = aws_iam_role.rds_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

#######################################
# Data Sources for Subnets
#######################################
data "aws_subnet" "subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["subnet-1"] # Replace with actual subnet name tag
  }
}

data "aws_subnet" "subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["subnet-2"] # Replace with actual subnet name tag
  }
}

#######################################
# DB Subnet Group
#######################################
resource "aws_db_subnet_group" "sub_grp" {
  name       = "mycutsubnet"
  subnet_ids = [data.aws_subnet.subnet_1.id, data.aws_subnet.subnet_2.id]

  tags = {
    Name = "My DB subnet group"
  }
}

#######################################
# Primary RDS Instance
#######################################
resource "aws_db_instance" "default" {
  allocated_storage       = 10
  db_name                 = "mydb"
  identifier              = "rds-test"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = "Cloud123"

  db_subnet_group_name    = aws_db_subnet_group.sub_grp.name
  parameter_group_name    = "default.mysql8.0"

  # Backups
  backup_retention_period = 7
  backup_window           = "02:00-03:00"

  # Monitoring
  monitoring_interval     = 60
  monitoring_role_arn     = aws_iam_role.rds_monitoring.arn

  # Maintenance
  maintenance_window      = "sun:04:00-sun:05:00"

  # Protection & deletion
  deletion_protection     = true
  skip_final_snapshot     = true

  # Networking
  publicly_accessible     = true

  depends_on = [
    aws_iam_role.rds_monitoring_attach
  ]

  tags = {
    Name = "Primary-RDS"
  }
}

#######################################
# Read Replica
#######################################
resource "aws_db_instance" "read_replica" {
  identifier             = "rds-test-replica"
  replicate_source_db    = aws_db_instance.default.id
  instance_class         = "db.t3.micro"
  publicly_accessible    = true
  db_subnet_group_name   = aws_db_subnet_group.sub_grp.name

  # Monitoring (optional)
  monitoring_interval    = 60
  monitoring_role_arn    = aws_iam_role.rds_monitoring.arn

  # Maintenance
  auto_minor_version_upgrade = true
  skip_final_snapshot        = true

  depends_on = [
    aws_db_instance.default,
    aws_iam_role.rds_monitoring_attach
  ]

  tags = {
    Name = "RDS-Read-Replica"
  }
}
