##############################
# DTS Synchronization Instance
##############################
variable "create_sync_instance" {
  description = "Controls if synchronization instance should be created"
  type        = bool
  default     = true
}

variable "auto_pay" {
  description = "Whether to automatically renew when it expires. Valid values: `true`, `false`."
  type        = bool
  default     = false
}

variable "auto_start" {
  description = "Whether to automatically start the task after the purchase completed. Valid values: `true`, `false`."
  type        = bool
  default     = false
}

variable "payment_type" {
  description = "(Required) The payment type of the resource. Valid values: `Subscription`, `PayAsYouGo`."
  type        = string
  default     = "PayAsYouGo"
}

variable "payment_duration" {
  description = "(Required When payment_type equals `Subscription`) The duration of prepaid instance purchase."
  type        = number
  default     = 1
}

variable "payment_duration_unit" {
  description = "(Required When payment_type equals `Subscription`) The payment duration unit. Valid values: `Month`, `Year`."
  type        = string
  default     = "Month"
}

variable "source_endpoint_region" {
  description = "(Required) The region of source instance."
  type        = string
  default     = ""
}

variable "destination_endpoint_region" {
  description = "(Required) The region of destination instance."
  type        = string
  default     = ""
}

variable "instance_class" {
  description = "The instance class. Valid values: `large`, `medium`, `micro`, `small`, `xlarge`, `xxlarge`. You can only upgrade the configuration, not downgrade the configuration. If you downgrade the instance, you need to submit a ticket."
  type        = string
  default     = "medium"
}

variable "compute_unit" {
  description = "The unit is the computing unit ComputeUnit (CU), 1CU=1vCPU+4 GB memory. The value range is an integer greater than or equal to 2. [ETL specifications](https://help.aliyun.com/document_detail/212324.html)."
  type        = number
  default     = null
}

variable "database_count" {
  description = "The number of private customized RDS instances under PolarDB-X. The default value is 1. This parameter needs to be passed only when `source_endpoint_engine_name` equals `drds`."
  type        = number
  default     = null
}

variable "quantity" {
  description = "The number of instances purchased."
  type        = number
  default     = null
}


#########################
# DTS Synchronization Job
#########################
variable "create_sync_job" {
  description = "Controls if synchronization job should be created"
  type        = bool
  default     = false
}

variable "dts_instance_id" {
  description = "The ID of dts synchronization instance. While create_sync_instance equals false, this parameter should be configured."
  type        = string
  default     = ""
}

variable "dts_job_name" {
  description = "(Required) The name of synchronization job."
  type        = string
  default     = ""
}

variable "data_initialization" {
  description = "(Required) Whether to perform full data migration or full data initialization. Valid values: `true`, `false`."
  type        = bool
  default     = false
}

variable "data_synchronization" {
  description = "(Required) Whether to perform incremental data migration or synchronization. Valid values: `true`, `false`."
  type        = bool
  default     = false
}

variable "structure_initialization" {
  description = "(Required) Whether to perform library table structure migration or initialization. Valid values: `true`, `false`."
  type        = bool
  default     = false
}

variable "synchronization_bidirectional" {
  description = "Whether to build a bidirectional channel. Valid values: `true`, `false`."
  type        = bool
  default     = false
}

variable "source_endpoint_instance_id" {
  description = "(Required) The ID of source instance."
  type        = string
  default     = ""
}

variable "source_endpoint_instance_type" {
  description = "(Optional) The type of source instance. If the source instance is a `PolarDB O` engine cluster, the source instance type needs to be `OTHER` or `EXPRESS` as a self-built database, and access via public IP or dedicated line. For the correspondence between supported source and target instances, see [Supported Databases](https://help.aliyun.com/document_detail/131497.htm). When the source instance is a self-built database, you also need to perform corresponding preparations, for details, see [Preparations Overview](https://help.aliyun.com/document_detail/146958.htm). Valid values: `CEN`, `DG`, `DISTRIBUTED_DMSLOGICDB`, `ECS`, `EXPRESS`, `MONGODB`, `OTHER`, `PolarDB`, `POLARDBX20`, `RDS`."
  type        = string
  default     = "RDS"
}

variable "source_endpoint_engine_name" {
  description = "(Optional) The type of source database. The default value is `MySQL`. For the correspondence between supported source libraries and target libraries, see [Supported Databases](https://help.aliyun.com/document_detail/131497.htm). When the database type of the source instance is `MONGODB`, you also need to pass in some information in the reserved parameter `Reserve`, for the configuration method, see the description of Reserve parameters. Valid values: `AS400`, `DB2`, `DMSPOLARDB`, `HBASE`, `MONGODB`, `MSSQL`, `MySQL`, `ORACLE`, `PolarDB`, `POLARDBX20`, `POLARDB_O`, `POSTGRESQL`, `TERADATA`."
  type        = string
  default     = "MySQL"
}

variable "destination_endpoint_instance_type" {
  description = "(Optional) The type of destination instance. If the destination instance is a `PolarDB O` engine cluster, the destination instance type needs to be `OTHER` or `EXPRESS` as a self-built database, and access via public IP or dedicated line. For the correspondence between supported destination and target instances, see [Supported Databases](https://help.aliyun.com/document_detail/131497.htm). When the destination instance is a self-built database, you also need to perform corresponding preparations, for details, see [Preparations Overview](https://help.aliyun.com/document_detail/146958.htm). Valid values: `CEN`, `DG`, `DISTRIBUTED_DMSLOGICDB`, `ECS`, `EXPRESS`, `MONGODB`, `OTHER`, `PolarDB`, `POLARDBX20`, `RDS`."
  type        = string
  default     = "RDS"
}

variable "destination_endpoint_engine_name" {
  description = "(Optional) The type of destination database. The default value is `MySQL`. For the correspondence between supported destination libraries and target libraries, see [Supported Databases](https://help.aliyun.com/document_detail/131497.htm). When the database type of the destination instance is `MONGODB`, you also need to pass in some information in the reserved parameter `Reserve`, for the configuration method, see the description of Reserve parameters. Valid values: `AS400`, `DB2`, `DMSPOLARDB`, `HBASE`, `MONGODB`, `MSSQL`, `MySQL`, `ORACLE`, `PolarDB`, `POLARDBX20`, `POLARDB_O`, `POSTGRESQL`, `TERADATA`."
  type        = string
  default     = "MySQL"
}

variable "source_endpoint_database_name" {
  description = "(Required) The name of the database to which the migration object belongs in the source instance."
  type        = string
  default     = ""
}

variable "source_endpoint_user_name" {
  description = "(Required) The username of database account."
  type        = string
  default     = ""
}

variable "source_endpoint_password" {
  description = "(Required) The password of database account."
  type        = string
  default     = ""
}

variable "destination_endpoint_instance_id" {
  description = "(Required) The ID of destination instance."
  type        = string
  default     = ""
}

variable "destination_endpoint_database_name" {
  description = "(Required) The name of the database to which the migration object belongs in the target instance."
  type        = string
  default     = ""
}

variable "destination_endpoint_user_name" {
  description = "(Required) The username of database account."
  type        = string
  default     = ""
}

variable "destination_endpoint_password" {
  description = "(Required) The password of database account."
  type        = string
  default     = ""
}

variable "delay_notice" {
  description = "The delay notice. Valid values: `true`, `false`."
  type        = bool
  default     = false
}

variable "delay_phone" {
  description = "The delay phone. The mobile phone number of the contact who delayed the alarm. Multiple mobile phone numbers separated by English commas ,. This parameter currently only supports China stations, and only supports mainland mobile phone numbers, and up to 10 mobile phone numbers can be passed in."
  type        = string
  default     = ""
}

variable "delay_rule_time" {
  description = "The delay rule time. When delay_notice is set to true, this parameter must be passed in. The threshold for triggering the delay alarm. The unit is second and needs to be an integer. The threshold can be set according to business needs. It is recommended to set it above 10 seconds to avoid delay fluctuations caused by network and database load."
  type        = string
  default     = "60"
}

variable "error_notice" {
  description = "The error notice. Valid values: `true`, `false`."
  type        = bool
  default     = false
}

variable "error_phone" {
  description = "The error phone. The mobile phone number of the contact who error the alarm. Multiple mobile phone numbers separated by English commas ,. This parameter currently only supports China stations, and only supports mainland mobile phone numbers, and up to 10 mobile phone numbers can be passed in."
  type        = string
  default     = ""
}

variable "db_list" {
  description = "(Required) Migration object, with the format of JSON strings. For detailed definition instructions, please refer to [The description of migration, synchronization or subscription objects](https://help.aliyun.com/document_detail/209545.html)."
  type        = string
  default     = ""
}

variable "dts_job_status" {
  description = "The status of the resource. Valid values: `Synchronizing`, `Suspending`. You can stop the task by specifying `Suspending` and start the task by specifying `Synchronizing`."
  type        = string
  default     = "Synchronizing"
}

variable "checkpoint" {
  description = "The start point or synchronization point of incremental data migration, the format is Unix timestamp, and the unit is seconds."
  type        = string
  default     = ""
}

variable "reserve" {
  description = "DTS reserves parameters, the format is a JSON string, you can pass in this parameter to complete the source and target database information (such as the data storage format of the target Kafka database, the instance ID of the cloud enterprise network CEN). For more information, please refer to the parameter [description of the Reserve parameter](https://help.aliyun.com/document_detail/273111.html)."
  type        = string
  default     = ""
}

variable "source_endpoint_ip" {
  description = "The IP of source endpoint. When `source_endpoint_instance_type` is `OTHER`, `EXPRESS`, `DG`, `CEN`, this parameter is available and must be passed in."
  type        = string
  default     = ""
}

variable "source_endpoint_port" {
  description = "The port of source endpoint. When the source instance is a self-built database, this parameter is available and must be passed in."
  type        = string
  default     = ""
}

variable "source_endpoint_oracle_sid" {
  description = "The SID of Oracle database. When the value of SourceEndpointEngineName is Oracle and the Oracle database is a non-RAC instance, this parameter is available and must be passed in."
  type        = string
  default     = ""
}

variable "source_endpoint_owner_id" {
  description = "The ID of Alibaba Cloud account to which the source instance belongs. Note: passing in this parameter means performing data migration or synchronization across Alibaba Cloud accounts, and you also need to pass in the `source_endpoint_role` parameter."
  type        = string
  default     = ""
}

variable "source_endpoint_role" {
  description = "The name of the role configured for the cloud account to which the source instance belongs. Note: this parameter must be passed in when performing cross Alibaba Cloud account data migration or synchronization. For the permissions and authorization methods required by this role, please refer to [How to configure RAM authorization when cross-Alibaba Cloud account data migration or synchronization](https://help.aliyun.com/document_detail/48468.htm)."
  type        = string
  default     = ""
}

variable "destination_endpoint_ip" {
  description = "The IP of destination endpoint. When `destination_endpoint_instance_type` is `OTHER`, `EXPRESS`, `DG`, `CEN`, this parameter is available and must be passed in."
  type        = string
  default     = ""
}

variable "destination_endpoint_port" {
  description = "The port of destination endpoint. When the target instance is a self-built database, this parameter is available and must be passed in."
  type        = string
  default     = ""
}

variable "destination_endpoint_oracle_sid" {
  description = "The SID of Oracle database. Note: when the value of `destination_endpoint_engine_name` is Oracle and the Oracle database is a non-RAC instance, this parameter is available and must be passed in."
  type        = string
  default     = ""
}

#####################
# DTS Job Moitor Rule
#####################
variable "create_monitor_rule" {
  description = "Controls if monitor rule should be created"
  type        = bool
  default     = false
}

variable "monitor_rule_type" {
  description = "(Required) Monitoring rules of type, valid values: `delay`, `error`."
  type        = string
  default     = "delay"
}

variable "monitor_rule_delay_time" {
  description = "Trigger delay alarm threshold, which is measured in seconds."
  type        = string
  default     = "60"
}

variable "monitor_rule_phone" {
  description = "The alarm is triggered after notification of the contact phone number, A plurality of phone numbers between them with a comma (,) to separate."
  type        = string
  default     = ""
}

variable "monitor_rule_status" {
  description = "Whether to enable monitoring rules, valid values: `Y`, `N`."
  type        = string
  default     = "Y"
}