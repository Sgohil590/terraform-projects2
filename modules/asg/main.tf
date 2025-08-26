

resource "aws_launch_template" "this" {

 name_prefix   = var.name
 image_id      = var.ami_id
 instance_type = var.instance_type


network_interfaces {
  associate_public_ip_address = true
  security_groups             = var.security_group_ids 
}

lifecycle {
  create_before_destroy= true
}

tag_specifications {
  resource_type = "Instance"

 tags = merge(
 {
   Name = var.name
},
  var.tags
)
}
}

resource "aws_autoscaling_group" "this" {
   name                      = "${var.name}--asg"
   desired_capacity          =  var.desired_capacity 
   max_size                  =  var .max_size
   min_size                  =  var.min_size
   vpc_zone_identifier       =  var.subnet_ids
   health_check_type         =  "EC2"
   health_check_grace_period =   300

launch_template  {
   id       = aws_launch_template.this.id
   version  = "$Latest"
}

target_group_arns  = var.target_group_arns


tag {          
   key                  = "Name"
   value                =  var.name
   propagate_at_launch  = true 
}
}

