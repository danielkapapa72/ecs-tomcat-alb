# Create Hosted Zone
resource "aws_route53_zone" "this" {
  name = var.domain_name
}

# Create DNS record → NLB
resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.this.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.nlb_dns
    zone_id                = "Z2IFOLAFXWLO4F" # NLB hosted zone ID
    evaluate_target_health = true
  }
}

# Outputs
output "zone_id" {
  value = aws_route53_zone.this.zone_id
}

output "name_servers" {
  value = aws_route53_zone.this.name_servers
}