
# Application Load Balancer
resource "aws_lb" "this" {
  name               = "${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = merge(var.tags, { Name = "${var.environment}-alb" })
}

# Target Group
resource "aws_lb_target_group" "this" {
  name     = "${var.environment}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    protocol            = "HTTP"
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = merge(var.tags, { Name = "${var.environment}-tg" })
}

# Attach EC2 instances to Target Group
resource "aws_lb_target_group_attachment" "this" {
  for_each = toset(var.target_instance_ids)
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = each.value
  port             = 80
}

# Listener for HTTP
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

