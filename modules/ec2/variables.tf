variable "ami_id" {
    description = "AMI ID to use for EC2 instance"
    type        = string
} 


variable "instance_type" {
    description = "EC2 instance_type"
    type        = string
    default     = "t2.micro"
} 


variable "subnet_id" {
    description = "Subnet ID to launch instance"
    type = string
} 

variable "key_name" {
    description = "key pair for SSH access"
    type        = string
} 

variable "region" {
    description = "aws region"
    type        = string
    default     = "us-east-1"
} 

variable "vpc_id" {
description = "vpc ID where security group will be created"
type        = string 
}
