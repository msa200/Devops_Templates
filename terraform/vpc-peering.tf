resource "aws_vpc_peering_connection" "peering" {
  peer_owner_id = var.shared_services_acceptor_account_id
  vpc_id        = aws_vpc.vpc.id
  peer_vpc_id   = data.aws_vpc.shared_services_acceptor_vpc_tags.id
  peer_region   = var.shared_services_acceptor_region
  auto_accept   = false

  tags = {
    var.shared_services_1_acceptor_peering_tags
    }
}

resource "aws_vpc_peering_connection_accepter" "acceptor" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
  auto_accept               = true

  tags = {
    side = "Accepter"
  }

  depends_on = [
    aws_vpc_peering_connection.peering
  ]

}
