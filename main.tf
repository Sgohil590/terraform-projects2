
provider "aws" {
 region = var.region 
}

module "vpc" {
 source              = "./modules/vpc" 
 vpc_cidr            = "10.0.0.0/16" 
 public_subnet_cidr  = "10.0.1.0/24"
 private_subnet_cidr = "10.0.2.0/24" 
 region              = var.region 
}

module "ec2" {
 source         = "./modules/ec2" 
 ami_id    	= "ami-0fc5d935ebf8bc3bc" 
 instance_type  = "t2.micro"
 subnet_id      = module.vpc.public_subnet_id 
  vpc_id = module.vpc.vpc_id 
 key_name       = var.key_name
 region         = var.region 
}
 
