data "aws_route53_zone" "primary" {
  name         = "${var.domain_name}."
  private_zone = false
}

resource "aws_route53_record" "apex_a" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = 300
  records = local.github_pages_apex_ipv4
}

resource "aws_route53_record" "apex_aaaa" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = var.domain_name
  type    = "AAAA"
  ttl     = 300
  records = local.github_pages_apex_ipv6
}

resource "aws_route53_record" "github_pages_subdomain_a" {
  for_each = local.github_pages_subdomains

  zone_id = data.aws_route53_zone.primary.zone_id
  name    = each.value
  type    = "A"
  ttl     = 300
  records = local.github_pages_apex_ipv4
}

resource "aws_route53_record" "github_pages_subdomain_aaaa" {
  for_each = local.github_pages_subdomains

  zone_id = data.aws_route53_zone.primary.zone_id
  name    = each.value
  type    = "AAAA"
  ttl     = 300
  records = local.github_pages_apex_ipv6
}
