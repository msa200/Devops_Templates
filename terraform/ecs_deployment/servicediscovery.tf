  
resource "aws_service_discovery_service" "redishost" {
  name = "redis"

  dns_config {
    namespace_id = "${substr(data.aws_route53_zone.private_dns.comment,102,19)}"

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}