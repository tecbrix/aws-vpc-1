resource "aws_db_subnet_group" "rds" {
  depends_on = [
    aws_subnet.privatesubnets
  ]
  name = "rds-subnetgroup"
  subnet_ids = [
    for index in aws_subnet.privatesubnets[*].id :
    index
  ]

  tags = {
    Name = "rds-subngroup"
  }
}
