resource "aws_acm_certificate" "acm" {
  domain_name               = var.domain_name
  validation_method         = "DNS"
  subject_alternative_names = var.san_domains

  tags = {
    Name = "${var.acm_name}-cert"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }

  name    = each.value.name
  type    = each.value.type
  zone_id = var.hosted_zone_id
  records = [each.value.value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "acm_certificate_validation" {
  certificate_arn         = aws_acm_certificate.acm.arn
  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
}
