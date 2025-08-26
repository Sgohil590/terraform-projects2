
variable "name" {
 type   	= string
 description     = "ASG name prefix"
}

variable   "ami_id" {
  type         = string
  description  = "AMI ID for instances"

}
variable       "instance_type" {
   type         = string
   description  = "Instance type"
}

variable "subnet_ids" { 
  type        = list(string)
  description = "Subnets for ASG instances"

}
variable "security_group_ids" {
  type        = list(string)
  description = "Security group for ASG instances"
}

variable "desired_capacity" {
  type       = number
  default    = 2
}
variable "min_size" {
  type    = number
  default = 1
}

variable "max_size" {
   type    = number
   default = 3
}
variable "target_group_arns" {
  type          = list(string)
  description   = "ALB Target Group ARNs"
  default       = [] 
}
variable "tags" {
  type     = map(string)
  default  = {} 
}
   
