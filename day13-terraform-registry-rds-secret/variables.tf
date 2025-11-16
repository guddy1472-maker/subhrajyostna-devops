#################################
# General AWS & Networking Vars
#################################
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "VPC ID for the RDS instance"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of subnet IDs for RDS subnet group"
  type        = list(string)
  default     = []
}

#################################
# RDS Configuration
#################################
variable "rds_identifier" {
  description = "Name of the RDS instance"
  type        = string
  default     = "my-db"
}

variable "engine" {
  description = "RDS database engine"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "MySQL version (full version required)"
  type        = string
  default     = "8.0.37"
}

variable "major_engine_version" {
  description = "Major engine version (for option group)"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "Database instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Allocated storage size in GB"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Initial MySQL database name"
  type        = string
  default     = "mydatabase"
}

variable "db_username" {
  description = "Master username"
  type        = string
  default     = "admin"
}

#################################
# Security / Secrets Manager
#################################
variable "manage_master_user_password" {
  description = "Enable Secrets Manager for RDS password"
  type        = bool
  default     = true
}

variable "password_rotation_days" {
  description = "Automatic rotation interval for Secrets Manager"
  type        = number
  default     = 30
}

#################################
# Networking & SG
#################################
variable "vpc_security_group_ids" {
  description = "List of security group IDs for RDS"
  type        = list(string)
  default     = []
}

#################################
# Backups / Maintenance / Protection
#################################
variable "skip_final_snapshot" {
  description = "Skip the final snapshot on deletion"
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}

#################################
# Tags
#################################
variable "tags" {
  description = "Project-level resource tags"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "rds-secrets-demo"
  }
}