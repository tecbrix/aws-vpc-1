output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = aws_eip.nateIP.public_ip
}