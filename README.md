AWS VPC Terraform module

Terraform module which creates VPC resources on AWS.

Usage
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "test"
  env  = "test"
}
