output "certificate_arn" {
  value       = aws_acm_certificate.acm.arn
  description = "ARN of the validated ACM certificate"
}
