
variable "region" {
 default = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID created by packer" 
  type        = string
}

variable "key_name" {
  description = "key pair for Ec2 ssh"
  type       = string 
  default     = "my-key" 
}
