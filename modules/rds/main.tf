
resource "aws_db_instance" "this" {
 identifier             = var.db_identifier
 allocated_storage      = var.allocated_storage
 engine                 = var.engine
 engine_version         = var.engine_version   
 instance_class         = var.instance_class
 username               = var.username
 password               = var.password
 parameter_group_name   = var.parameter_group_name
 db_subnet_group_name   = var.db_subnet_group_name 
 vpc_security_group_ids = var.vpc_security_group_ids
 skip_final_snapshot    = true 
 deletion_protection    = false  
}
