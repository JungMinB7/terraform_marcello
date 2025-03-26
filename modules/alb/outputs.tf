output "alb_dns_name" {
  value       = aws_lb.alb.dns_name
  description = "DNS name to access the ALB"
}

output "alb_arn" {
  value = aws_lb.alb.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.alb_target_group.arn
}
