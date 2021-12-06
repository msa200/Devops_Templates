resource "aws_service_discovery_private_dns_namespace" "company" {
  name        = "company"
  description = "example"
  vpc         = "${aws_vpc.company.id}"
}

