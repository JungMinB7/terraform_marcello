output "asg_name" {
  value       = aws_autoscaling_group.autoscaling_group.name
  description = "Auto Scaling Group Name"
}

output "lt_id" {
  value       = aws_launch_template.launch_template.id
  description = "Launch Template ID"
}
