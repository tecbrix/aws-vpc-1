# AWS VPC Terraform module

Terraform module which creates VPC resources on AWS.

### Usage
```
module "vpc" {
  source = "github.com/tecbrix/aws-vpc"
  name = "test"
  env  = "test"
}
```
