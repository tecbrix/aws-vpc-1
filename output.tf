output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = aws_eip.nateIP.public_ip
}

output "aws_db_subnet_group_name" {
  description = "subnet group for  rds"
  value       = aws_db_subnet_group.rds.name
}

output "pub_subnet_for_ec2" {
  description = "subnet for ec2"
  value       = aws_subnet.publicsubnets[0].id
}

output "vpc_cidr" {
  description = "vpc cidr"
  value       = var.main_vpc_cidr
}

output "vpc_id" {
  description = "vpc id"
  value       = aws_vpc.Main.id
}