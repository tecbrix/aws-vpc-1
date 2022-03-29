output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = aws_eip.nateIP.public_ip
}

output "aws_db_subnet_group_name" {
  description = "subnet group for  rds"
  value       = aws_db_subnet_group.rds.name
}