# Terraform ECS Fargate SI
[![Codeac](https://static.codeac.io/badges/3-16093684.svg "Codeac.io")](https://app.codeac.io/gitlab/terraform147)

## POC
Le projet POC permet de tester l'architecture choisie pour le SI.
Il regroupe l'essentiel des besoins pour un domaine : Un microservice coté command avec DB Mongo, un microservice coté projection avec DB SQL, une api graphQL et un frontend.

## Contenu

- Route53 (Création des DNS)
- ACM (Création du certificat SSL)
- VPC (Définition du réseau)
- ELB (Equilibreur de charge)
- ECS Cluster
- ECS Task Definition pour :
  - Reverse Proxy
  - Front ReactJS
  - COMMAND
    - API Rest
    - RabbitMQ Management
    - Domains + DB DynamoDB
    - Blockchain + DB DynamoDB
  - QUERY
    - GraphQL
    - Projection (ToDo) + DB Aurora

## Installation

### Import des modules
```
terraform init
```

### Création du VPC
```
terraform apply -target=module.vpc
```

### Création de tout le reste
```
terraform apply
```
