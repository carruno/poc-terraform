# AI Terraform - AWS - Security Group

Terraform module to create an AWS Security Group

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| egress\_cidrs | n/a | `list` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| egress\_tcp\_ports | List of Egress TCP ports separated by comma (80,443) that will be set as from/to ports | `string` | `"default_null"` | no |
| egress\_tcp\_range\_from | Start of the Egress TCP ports range | `string` | `"default_null"` | no |
| egress\_tcp\_range\_to | End of the Egress TCP ports range | `string` | `"default_null"` | no |
| egress\_udp\_ports | List of Egress UDP ports separated by comma (80,443) that will be set as from/to ports | `string` | `"default_null"` | no |
| egress\_udp\_range\_from | Start of the Egress UDP ports range | `string` | `"default_null"` | no |
| egress\_udp\_range\_to | End of the Egress UDP ports range | `string` | `"default_null"` | no |
| enable\_icmp | n/a | `bool` | `false` | no |
| enabled | Enable the creation of the Security Group | `bool` | `true` | no |
| ingress\_cidrs | n/a | `list` | `[]` | no |
| ingress\_tcp\_ports | List of Ingress TCP ports separated by comma (80,443) that will be set as from/to ports | `string` | `"default_null"` | no |
| ingress\_tcp\_range\_from | Start of the Ingress TCP ports range | `string` | `"default_null"` | no |
| ingress\_tcp\_range\_to | End of the Ingress TCP ports range | `string` | `"default_null"` | no |
| ingress\_udp\_ports | List of Ingress UDP ports separated by comma (80,443) that will be set as from/to ports | `string` | `"default_null"` | no |
| ingress\_udp\_range\_from | Start of the Ingress UDP ports range | `string` | `"default_null"` | no |
| ingress\_udp\_range\_to | End of the Ingress UDP ports range | `string` | `"default_null"` | no |
| is\_private\_subnet | n/a | `bool` | `false` | no |
| sg\_name | Name of the AWS Security Group | `string` | n/a | yes |
| tags | Defaut tags to associate to these resources | `map(string)` | n/a | yes |
| vpc\_cidr | ID of the AWS VPC to create the AWS Security Group | `string` | `""` | no |
| vpc\_id | ID of the AWS VPC to create the AWS Security Group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | ID of the Security Group |
| name | Name of the Security Group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
