variable "name" {
  default = "tf-example"
}

data "alicloud_db_zones" "example" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
}

data "alicloud_db_instance_classes" "example" {
  zone_id                  = data.alicloud_db_zones.example.zones.0.id
  engine                   = "MySQL"
  engine_version           = "8.0"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
  instance_charge_type     = "PostPaid"
}

resource "alicloud_vpc" "example" {
  vpc_name   = "terraform-example"
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "example" {
  vpc_id       = alicloud_vpc.example.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_db_zones.example.zones.0.id
  vswitch_name = "terraform-example"
}

resource "alicloud_security_group" "example" {
  name   = "terraform-example"
  vpc_id = alicloud_vpc.example.id
}

## Source RDS MySQL
resource "alicloud_db_instance" "source" {
  engine               = "MySQL"
  engine_version       = "8.0"
  instance_type        = data.alicloud_db_instance_classes.example.instance_classes.1.instance_class
  instance_storage     = data.alicloud_db_instance_classes.example.instance_classes.1.storage_range.min
  instance_charge_type = "Postpaid"
  vswitch_id           = alicloud_vswitch.example.id
  instance_name        = "rds-mysql-source"
}

resource "alicloud_db_database" "source_db" {
  instance_id = alicloud_db_instance.source.id
  name        = "test_database"
}

resource "alicloud_rds_account" "source_account" {
  db_instance_id   = alicloud_db_instance.source.id
  account_name     = "test_mysql"
  account_password = "N1cetest"
}

resource "alicloud_db_account_privilege" "source_privilege" {
  instance_id  = alicloud_db_instance.source.id
  account_name = alicloud_rds_account.source_account.name
  privilege    = "ReadWrite"
  db_names     = alicloud_db_database.source_db.*.name
}

## Target RDS MySQL
resource "alicloud_db_instance" "target" {
  engine               = "MySQL"
  engine_version       = "8.0"
  instance_type        = data.alicloud_db_instance_classes.example.instance_classes.1.instance_class
  instance_storage     = data.alicloud_db_instance_classes.example.instance_classes.1.storage_range.min
  instance_charge_type = "Postpaid"
  vswitch_id           = alicloud_vswitch.example.id
  instance_name        = "rds-mysql-target"
}

resource "alicloud_db_database" "target_db" {
  instance_id = alicloud_db_instance.target.id
  name        = "test_database"
}

resource "alicloud_rds_account" "target_account" {
  db_instance_id   = alicloud_db_instance.target.id
  account_name     = "test_mysql"
  account_password = "N1cetest"
  account_type     = "Super"
}

module "example" {
  source = "../.."

  #alicloud_dts_synchronization_instance
  create_sync_instance        = true
  auto_pay                    = var.auto_pay
  auto_start                  = var.auto_start
  payment_type                = var.payment_type
  payment_duration            = var.payment_duration
  payment_duration_unit       = var.payment_duration_unit
  source_endpoint_region      = var.source_endpoint_region
  destination_endpoint_region = var.destination_endpoint_region
  instance_class              = var.instance_class

  #alicloud_dts_synchronization_job
  create_sync_job                    = true
  synchronization_bidirectional      = true
  dts_job_name                       = var.dts_job_name
  data_initialization                = var.data_initialization
  data_synchronization               = var.data_synchronization
  structure_initialization           = var.structure_initialization
  source_endpoint_instance_id        = alicloud_db_instance.source.id
  source_endpoint_database_name      = var.source_endpoint_database_name
  source_endpoint_user_name          = alicloud_rds_account.source_account.account_name
  source_endpoint_password           = alicloud_rds_account.source_account.account_password
  destination_endpoint_instance_id   = alicloud_db_instance.target.id
  destination_endpoint_database_name = var.destination_endpoint_database_name
  destination_endpoint_user_name     = alicloud_rds_account.target_account.account_name
  destination_endpoint_password      = alicloud_rds_account.target_account.account_password
  delay_notice                       = var.delay_notice
  delay_phone                        = var.delay_phone
  delay_rule_time                    = var.delay_rule_time
  error_notice                       = var.error_notice
  error_phone                        = var.error_phone
  db_list                            = var.db_list
  dts_job_status                     = var.dts_job_status

  #alicloud_dts_job_monitor_rule
  create_monitor_rule     = true
  monitor_rule_type       = var.monitor_rule_type
  monitor_rule_delay_time = var.monitor_rule_delay_time
  monitor_rule_phone      = var.monitor_rule_phone
  monitor_rule_status     = var.monitor_rule_status
}
