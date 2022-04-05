# AWS VPC Terraform module

Terraform module which creates VPC resources on AWS. Will create two private and public subnets by default.

### Usage
```
git clone https://github.com/tecbrix/aws-vpc.git
cd aws-vpc
terraform apply
```
### Usage as module 
```
module "vpc" {
  source = "github.com/tecbrix/aws-vpc"
  name = "test"
  env  = "test"
}
```
