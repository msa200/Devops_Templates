resource "aws_vpc" "company" {
  cidr_block = "10.1.0.0/16"
    tags = {
    Name = "company"
  } 
  enable_dns_hostnames = "true"
  enable_dns_support = "true"
}
