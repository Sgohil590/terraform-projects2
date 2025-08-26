
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

resource "aws_security_group" "alb_sg" {
 name 	= "alb-sg"
 vpc_id = module.vpc.vpc_id


 ingress {
  from_port   = 80
  to_port     = 80 
  protocol    = "tcp"
 cidr_blocks  = ["0.0.0.0/0"]
}

egress {
 from_port   = 0
 to_port     = 0
 protocol    = "-1"
 cidr_blocks = ["0.0.0.0/0"]
}
 tags = { Name = "alb-sg" }
}

module "alb" {
 source                = "./modules/alb"
 vpc_id                = module.vpc.vpc_id
 public_subnet_ids     = [module.vpc.public_subnet_id]
 alb_security_group_id = aws_security_group.alb_sg.id 
 target_instance_ids  = [module.ec2.instance_id]
 environment           = "dev"
 tags = { 
   project = "TerraformDemo" 
} 
}

output "alb_dns_name" {
 value = module.alb.alb_dns_name
} 

#security Group for AG instances

resource  "aws_security_group" "asg_sg" {
  name   = "asg-sg"
  vpc_id = module.vpc.vpc_id

ingress {
  from_port       = 80 
  to_port         = 80 
  protocol        = "tcp"
  security_groups = [aws_security_group.alb_sg.id] # allow only alb

}


egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

}

tags = { Name = "alb-sg" }
}


# Autoscaling Group module

module "asg" {
  source              = "./modules/asg"
  name                = "web-asg"
  ami_id              = "ami-0fc5d935ebf8bc3bc"
  instance_type       =  "t2.micro"
  subnet_ids          = [module.vpc.public_subnet_id]
  security_group_ids  = [aws_security_group.asg_sg.id]
  desired_capacity    = 2
  min_size            = 1
  max_size            = 3
  target_group_arns   = [module.alb.target_group_arn]
}

module "rds" {
  source           = "./modules/rds"
  engine           = "mysql"
  engine_version   = "8.0.36"
  instance_class   = "db.t3.micro"
  username         = "sahil"
  password         = "sahil@123"


#intergrate_sith_my_existing_vpc 

vpc_security_group_ids  = [aws_security_group.asg_sg.id] 
subnet_ids              = [module.vpc.private_subnet_id] 
  db_identifier          = "demo-db"
  db_subnet_group_name   = "rds-subnet-group"  # can match the subnet group resource name in the module
} 


