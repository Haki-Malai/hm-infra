output "route53_zone_id" {
  description = "Route 53 hosted zone ID for the primary domain."
  value       = data.aws_route53_zone.primary.zone_id
}

output "managed_domains" {
  description = "Domains managed by this Terraform root."
  value = {
    apex       = var.domain_name
    subdomains = local.github_pages_subdomains
  }
}

output "github_pages_host" {
  description = "GitHub Pages host used for CNAME records."
  value       = var.github_pages_host
}

