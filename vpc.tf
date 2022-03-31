data "aws_availability_zones" "azs" {}
#Create the VPC
 resource "aws_vpc" "Main" {                # Creating VPC here
   cidr_block       = var.main_vpc_cidr     # Defining the CIDR block use 10.0.0.0/24 for demo
   instance_tenancy = "default"
   enable_dns_hostnames = true
   tags             = local.tags
 }
 #Create Internet Gateway and attach it to VPC
 resource "aws_internet_gateway" "IGW" {    # Creating Internet Gateway
    vpc_id =  aws_vpc.Main.id               # vpc_id will be generated after we create VPC
    tags             = local.tags
 }
 #Create a Public Subnets.
 resource "aws_subnet" "publicsubnets" {    # Creating Public Subnets
   count  = length(var.public_subnets)
   vpc_id =  aws_vpc.Main.id
   availability_zone = data.aws_availability_zones.azs.names[count.index]
   cidr_block = "${var.public_subnets[count.index]}"        # CIDR block of public subnets
   tags = {
      env = var.env
      Name = "${var.name}-pub-${count.index}"
  }
 }
 #Create a Private Subnet                   # Creating Private Subnets
 resource "aws_subnet" "privatesubnets" {
  count  = length(var.private_subnets)
   vpc_id =  aws_vpc.Main.id
   availability_zone = data.aws_availability_zones.azs.names[count.index]
   cidr_block = "${var.private_subnets[count.index]}"          # CIDR block of private subnets
   tags = {
      env = var.env
      Name = "${var.name}-prvt-${count.index}"
  }
 }
 #Route table for Public Subnet's
 resource "aws_route_table" "PublicRT" {    # Creating RT for Public Subnet
    vpc_id =  aws_vpc.Main.id
         route {
    cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.IGW.id
     }
    tags             = local.tags
 }
 #Route table for Private Subnet's
 resource "aws_route_table" "PrivateRT" {    # Creating RT for Private Subnet
   vpc_id = aws_vpc.Main.id
   route {
   cidr_block = "0.0.0.0/0"             # Traffic from Private Subnet reaches Internet via NAT Gateway
   nat_gateway_id = aws_nat_gateway.NATgw.id
   }
   tags             = local.tags
 }
 #Route table Association with Public Subnet's
 resource "aws_route_table_association" "PublicRTassociation" {
    count  = length(var.public_subnets)
    subnet_id = aws_subnet.publicsubnets[count.index].id
    route_table_id = aws_route_table.PublicRT.id
 }
 #Route table Association with Private Subnet's
 resource "aws_route_table_association" "PrivateRTassociation" {
    count  = length(var.private_subnets)
    subnet_id = aws_subnet.privatesubnets[count.index].id
    route_table_id = aws_route_table.PrivateRT.id
 }
 resource "aws_eip" "nateIP" {
   vpc   = true
   tags             = local.tags
 }
 #Creating the NAT Gateway using subnet_id and allocation_id
 resource "aws_nat_gateway" "NATgw" {
   allocation_id = aws_eip.nateIP.id
   subnet_id = aws_subnet.publicsubnets[0].id
   tags             = local.tags
 }