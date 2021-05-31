terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.42.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

# Route53 add root domain name
module "route53" {
  source = "./modules/route53"
  root_domain_name = "sonergia.org"
}
# ACM add SSL certificate for domain
module "certs" {
  source = "./modules/acm"
  domain_names = ["sonergia.org", "*.sonergia.org"]
  name = "sonergia.org"
  type = ""
}
# VPC add network
module "vpc" {
  source = "./modules/vpc"
  availability_zones = data.aws_availability_zones.available.names
  enable_dns_hostnames = true
  enable_dns_support = true
  name = "poc-new-archi"
  public_start_ip = "0"
  private_start_ip = "10"
  subnet_prefix = "10.0"
  tags = {
    Name = "poc-new-archi-vpc"
  }
  vpc_cidr = "10.0.0.0/16"
}

# ECS add container service cluster
module "ecs" {
  source = "./modules/ecs"
  name = "poc-new-archi"
  #region = ""
}

# Route53 add subdomain for application
data "aws_route53_zone" "dev" {
  name = "dev.sonergia.org"
  #private_zone = false
  depends_on = [module.route53]
}
# ELB add Elastic Load Balancer for subdomain
module "elb-dev" {
  source = "./modules/elb"
  name = "poc-new-archi-dev"
  vpc_id = module.vpc.vpc_id
  log_bucket_name = "poc-new-archi"
  zone_id = data.aws_route53_zone.dev.zone_id
}

#data "aws_route53_zone" "stg" {
#  name = "stg.sonergia.org"
#  #private_zone = false
#  depends_on = [module.route53]
#}
#module "elb-stg" {
#  source = "../modules/elb"
#  name = "poc-new-archi-stg"
#  vpc_id = data.aws_vpc.selected.id
#  log_bucket_name = "poc-new-archi"
#  zone_id = data.aws_route53_zone.stg.zone_id
#  depends_on = [data.aws_vpc.selected]
#}

# Applications module: define all applications resources
module "applications" {
  source = "./applications"

  applications = tomap({
    reverse_proxy = {
    }
    #reactjs = {
    #}
    #rabbitmq = {
    #  image_tag          = "rabbitmq-latest"
    #}
    #db_todo_projection = {
    #}
  })
}

#module "ecs-service" {
#  source = "./modules/ecs-task"
#  app_name = "poc-new-archi-dev"
#  iam_role_arn = ""
#  container_name = "react"
#  container_port = "80"
#  health_check_url = "/"
#  container_tag = "latest"
#  registry_url = ""
#  vpc_id = module.vpc.vpc_id
#  cloudwatch_name = "poc-new-archi_si"
#  cluster_id = module.ecs.cluster_id
#  allow_public_access = true
#}

#module "rabbit" {
#  source = "./modules/rabbitmq"
#  domain = "cogepart"
#  app_name = "poc-new-archi-rabbit"
#  cloudwatch_name = "poc-new-archi-rabbit"
#}

#module "rabbitmq-cluster" {
#  source = "./modules/rabbitmq-cluster"
#  app_name = ""
#  cloudwatch_log_group = ""
#  container_name = ""
#  container_tag = ""
#  domain = ""
#  registry_url = ""
#  setup_prometheus = false
#  setup_dns = false
#}
