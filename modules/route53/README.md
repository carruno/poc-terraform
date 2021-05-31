# Terraform Route53 Module

## Contains

- Create Route53 zones for dev, stg and prod

## Outputs

- List of zone ids

## How to use

### Setup Module

```
module "route53" {
  source = "git@gitlab.com:terraform147/route53.git"
  root_domain_name = ""
}
```

### Import module

```
terraform init
```

## Give a star :stars:

## Want to improve or fix something? Fork me and send a MR! :punch: