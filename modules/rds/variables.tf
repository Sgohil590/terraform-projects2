

variable "db_identifier" {} 
variable "allocated_storage" { default = 20 } 
variable "engine" { default = "mysql" }
variable "engine_version"   { default = "8.0" }
variable "instance_class" { default = "db.t3.micro" }
variable  "username" {} 
variable  "password" { sensitive = true }
variable  "parameter_group_name" { default = "default.mysql8.0" } 
variable  "db_subnet_group_name" {} 
variable  "vpc_security_group_ids"  { type = list(string) }

variable "subnet_ids" {
  description = "List of subnet IDs for RDS placement"
  type        = list(string)
  default     = []
}
