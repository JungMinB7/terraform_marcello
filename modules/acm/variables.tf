variable "acm_name" {
  description = "Prefix for resource naming"
  type        = string
}

variable "domain_name" {
  description = "Main domain name"
  type        = string
}

variable "san_domains" {
  description = "List of Subject Alternative Names (e.g. www.example.com)"
  type        = list(string)
  default     = []
}

variable "hosted_zone_id" {
  description = "Route53 Hosted Zone ID to create DNS validation records"
  type        = string
}
