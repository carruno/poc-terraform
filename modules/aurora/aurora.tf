resource "aws_db_subnet_group" "this" {
  name       = "${var.app_name}-db-subnet-group"
  subnet_ids = tolist(data.aws_subnet_ids.private.ids)
  tags = {
    Name = "${var.app_name}-aurora-db-subnet-group"
  }
}

module "kms_key" {
  source   = "../kms-key"
  app_name = "${var.app_name}-db"
}

resource "random_password" "db_master_pass" {
  length  = 41
  special = false
}

resource "aws_ssm_parameter" "db_master_pass" {
  name   = "/${var.app_name}/general/DB_MASTER_PASS"
  type   = "SecureString"
  key_id = module.kms_key.id
  value  = random_password.db_master_pass.result
  tags = {
    Product = var.app_name
  }
}

resource "aws_rds_cluster" "default" {
  cluster_identifier        = "${var.app_name}-aurora-cluster"
  availability_zones        = var.availability_zones
  backup_retention_period   = var.backup_retention_period
  copy_tags_to_snapshot     = true
  database_name             = replace(var.app_name, "-", "_")
  db_subnet_group_name      = aws_db_subnet_group.this.name
  #deletion_protection       = true
  engine                    = var.engine_type
  engine_mode               = "serverless"
  enable_http_endpoint      = true
  final_snapshot_identifier = "${var.app_name}-aurora-cluster-final-snapshot"
  master_username           = var.master_db_user
  master_password           = random_password.db_master_pass.result
  vpc_security_group_ids    = [aws_security_group.this.id]
  kms_key_id                = module.kms_key.arn
  scaling_configuration {
    auto_pause               = true
    max_capacity             = var.scaling_max_capacity
    min_capacity             = var.scaling_min_capacity
    seconds_until_auto_pause = 300
  }
  tags = {
    Product = var.app_name
  }
}

resource "aws_ssm_parameter" "db_writer_node" {
  name  = "/${var.app_name}/general/DB_WRITER_NODE"
  type  = "String"
  value = aws_rds_cluster.default.endpoint
  tags = {
    Product = var.app_name
  }
}
