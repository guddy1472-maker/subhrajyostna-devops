output "rds_endpoint" {
  description = "RDS connection endpoint"
  value       = module.rds.db_instance_endpoint
}

output "rds_port" {
  description = "RDS instance port"
  value       = module.rds.db_instance_port
}

output "rds_address" {
  description = "RDS instance address (DNS)"
  value       = module.rds.db_instance_address
}

output "rds_username" {
  description = "RDS master username"
  value       = module.rds.db_instance_username
  sensitive   = true
}

output "rds_arn" {
  description = "RDS instance ARN"
  value       = module.rds.db_instance_arn
}

output "rds_resource_id" {
  description = "RDS resource ID"
  value       = module.rds.db_instance_resource_id
}

output "rds_status" {
  description = "RDS instance status"
  value       = module.rds.db_instance_status
}
