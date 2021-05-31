#data "aws_ecr_repository" "db_todo_projection_repository" {
#  name = "poc-new-archi/db-todo-projection"
#}

#data "aws_availability_zones" "available" {
#  state = "available"
#}

#module "db_todo_projection" {
#  source = "../modules/aurora"
#  master_db_user = "admin"
#  db_port = "3306"
#  engine_type = "aurora"
#  engine_version = ""
#  instance_class = ""
#  app_name = "poc-new-archi"
#  availability_zones = data.aws_availability_zones.available.names
#  backup_retention_period = "3"
#  instances_amount = "1"
#}
