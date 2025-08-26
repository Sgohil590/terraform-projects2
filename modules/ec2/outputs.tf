
output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.nginx_instance.id
}

output "public_ip" {
  description = "EC2 Public IP"
  value       = aws_instance.nginx_instance.public_ip
}



