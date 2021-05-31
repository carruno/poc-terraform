# Terraform Certificate Module

## Contains

- Certificate for Domains

## Outputs

- Arn of the generated certificate

## How to use

### Setup Module

```
module "certs" {
  source = "git@gitlab.com:terraform147/certs.git"
  domain_name = ""
  name = ""
  type = "" 
}
```

### Import module

```
terraform init
```

## Give a star :stars:

## Want to improve or fix something? Fork me and send a MR! :punch: