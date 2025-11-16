# ------------------------------
# VPC / Subnets Inputs
# ------------------------------
variable "vpc_id" {
  description = "VPC ID where the RDS instance will be deployed"
  type        = string
  default     = null
}

variable "db_subnet_ids" {
  description = "List of subnet IDs for RDS subnet group"
  type        = list(string)
  default     = []
}

# ------------------------------
# RDS Inputs
# ------------------------------
variable "db_identifier" {
  description = "RDS instance identifier"
  type        = string
  default     = "my-rds-db"
}

variable "engine" {
  description = "RDS engine type"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "RDS engine version"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "RDS instance size"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Storage size in GB"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "database"
}

variable "db_username" {
  description = "Master username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Master password"
  type        = string
  sensitive   = true
}

variable "port" {
  description = "RDS port"
  type        = number
  default     = 3306
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default = {
    Environment = "Dev"
  }
}