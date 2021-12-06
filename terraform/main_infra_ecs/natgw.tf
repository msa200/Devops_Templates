resource "aws_nat_gateway" "company" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.public.id}"
    tags = {
    Name = "company"
  }
}
 
resource "aws_eip" "nat" {
  vpc = true
    tags = {
    Name = "company"
  }
}
