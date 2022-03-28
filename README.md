# AWS VPC Terraform module

Terraform module which creates VPC resources on AWS. Will create two private and public subnets by default.

### Usage
```
module "vpc" {
  source = "github.com/tecbrix/aws-vpc"
  name = "test"
  env  = "test"
}
```
