resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.company.id}"
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = false
  cidr_block        = "10.1.1.0/24"
    tags = {
    Name = "company_private"
  }
}
 
resource "aws_subnet" "private2" {
  vpc_id            = "${aws_vpc.company.id}"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = false
  cidr_block        = "10.1.4.0/24"
    tags = {
    Name = "company_private2"
  }
} 
resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.company.id}"
  cidr_block              = "10.1.2.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true
    tags = {
    Name = "company_public"
  }
}
  resource "aws_subnet" "public2" {
  vpc_id                  = "${aws_vpc.company.id}"
  cidr_block              = "10.1.3.0/24"
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = true
    tags = {
    Name = "company_public2"
  }
}
