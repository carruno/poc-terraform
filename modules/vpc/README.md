# Terraform VPC Module

[![Codeac.io](https://static.codeac.io/badges/3-15882460.svg)](https://app.codeac.io/gitlab/terraform147/vpc)

## VPC Doc:

Check in [this link](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html) the AWS documentation for VPC.

## This module creates:

- A VPC
- Public Subnets
- Public Route Table
- Private Subnets
- Private Route Table
- Internet Gateway
- Elastic Ip for Nat Gateway
- Nat Gateway

## Outputs

- VPC Id

## How to use

### Setup Module
```hcl
module "vpc" {
  source = "git@gitlab.com:terraform147/vpc.git"
  availability_zones = ""
  enable_dns_hostnames =
  enable_dns_support =
  name = ""
  public_start_ip = ""
  private_start_ip = ""
  subnet_prefix = ""
  tags = {}
  vpc_cidr = ""
}
```

### Import module

```
terraform init
```

### Validate changes

```sh
export AWS_REGION=us-east-1
terraform validate
```

## Give a star :stars:

## Want to improve or fix something? Fork me and send a MR! :punch:
