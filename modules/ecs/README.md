# Terraform ECS Module

## Contains

- Cluster
- Iam Setup

## Outputs

## How to use

### Choose a use case

> If you only need a cluster, with the basic iam permissions import the module like the example below:

#### Setup Module

```
module "ecs" {
  source = "git@gitlab.com:terraform147/ecs.git?ref=without_secrets"
  name = ""
  region = ""
}
```

> If you need a cluster, where your tasks need special access to System Manager Parameter Store and KMS Keys 
> import like the example below:

#### Setup Module

```
module "ecs" {
  source = "git@gitlab.com:terraform147/ecs.git"
  name = ""
  region = ""
}
```

### Import module

```
terraform init
```

## Give a star :stars:

## Want to improve or fix something? Fork me and send a MR! :punch:
