# RabbitMQ Cluster on AWS ECS with FARGATE

## Requirements

To setup the RabbitMQ Cluster you need to have the following infrastructure:

- Network Infrastructure like VPC, Subnets, etc. [Base Network Infra](https://gitlab.com/terraform147/vpc)
- External and Internal [Load Balancer](https://gitlab.com/terraform147/load-balancer)
- [ECS Cluster](gitlab.com/terraform147/ecs)
- An HTTPS Certificate allocated on your External Load Balancer on 443 port. (If you want to use HTTPS)
- [Prometheus](https://gitlab.com/terraform147/prometheus) 

## Import 
```
module "rabbitmq-cluster" {
    app_name = ""
    cloudwatch_log_group = ""
    container_name = ""
    container_tag = ""
    domain = ""
    registry_url = ""
    setup_prometheus = false
    setup_dns = false
}
```

### Load Balancing

 You will probably need to access the RabbitMQ management, you can do that by 
 accessing directly by the url of the  external load balancer, or setup a DNS 
 if you want to. 
 On the `load_balancer.tf` file you will find both options  If you are going to 
 use HTTPS you need to edit the `load_balancer.tf` file  and comment the 
 `resource "aws_lb_listener_rule" "http"` and discomment the
 `resource "aws_lb_listener_rule" "https"`.
 Also remember to set on your `terraform.tfvars` the variable `setup_dns` to true.

 ### Prometheus

 If you don't have [Prometheus](https://prometheus.io) set up, you need
 to comment its configurations on `security_group.tf` and on `load_balancer.tf`
 If you need to have Prometheus discomment its section on `service.tf`
 Also remember to set on your `terraform.tfvars` the variable `setup_prometheus`
 to true.
