provider "aws" { 
   region = var.region
}

resource "aws_security_group" "nginx_sg" {
  name   = "nginx-sg" 
  vpc_id =  var.vpc_id 

ingress {
  from_port   = 80 
  to_port     = 80 
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"] 
}

egress {
  from_port   = 0
  to_port     = 0
  protocol    ="-1"
  cidr_blocks = ["0.0.0.0/0"] 
}
tags = { Name = "nginx-sg" }
}
resource "aws_instance" "nginx_instance" {

 ami           	        = var.ami_id
 instance_type          = var.instance_type 
 subnet_id              = var.subnet_id 
 key_name               = var.key_name
 vpc_security_group_ids = [aws_security_group.nginx_sg.id]
 tags = { Name = "nginx-instance" }
 user_data = <<-EOF
              #!/bin/bash
              sudo systemctl start nginx
              EOF
}

