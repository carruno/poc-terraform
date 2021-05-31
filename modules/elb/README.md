# Terraform Load Balancer Module

It creates a Application Load Balancer on given subnets Id

## Contains

- Load Balancer
- Elb Target Group
- Elb Listener on port 80

## Outputs

- ELB Target Arn
- Security Group for ELB

## How to use

### Setup Module
```
module "elb" {
  source = "git@gitlab.com:terraform147/load-balancer.git"
  name = ""
  subnets = ""
  vpc_id = ""
}
```

### Import module

```
terraform init
```

## Give a star :stars:

## Want to improve or fix something? Fork me and send a MR! :punch:

## TODO

[ ] Create listener on port 443