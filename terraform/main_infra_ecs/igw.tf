resource "aws_internet_gateway" "company" {
  vpc_id = "${aws_vpc.company.id}"
    tags = {
    Name = "company"
  }
}