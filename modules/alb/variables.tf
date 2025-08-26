

variable "environment" {
  description = "Environment name (dev/staging/prod)"
  type        = string
}

variable "target_instance_ids" {
  description = "List of EC2 instance IDs to register in Target Group"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for ALB"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for ALB"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security Group ID for ALB"
  type        = string
}

variable "tags" {
  description = "Map of additional tags"
  type        = map(string)
  default     = {}
}


