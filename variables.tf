variable "administrator_login" {
  description = "The Administrator Login for the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
}

variable "administrator_password" {
  description = "The Password associated with the administrator_login for the PostgreSQL Server."
  type        = string
}

variable "auto_grow_enabled" {
  description = "(Optional) Defines whether autogrow is enabled or disabled for the storage. Valid values are Enabled or Disabled."
  type        = bool
  default     = true
}

variable "backup_retention_days" {
  default     = 7
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
  type        = number
}

variable "create_mode" {
  default     = "Default"
  description = "(Optional) The creation mode. Can be used to restore or replicate existing servers. Possible values are Default, Replica, GeoRestore, and PointInTimeRestore. Defaults to Default."
  type        = string
}

variable "creation_source_server_id" {
  default     = ""
  description = "(Optional) For creation modes other then default the source server ID to use."
  type        = string
}

variable "dbs" {
  default     = {}
  description = "Map of databases to create, values supported: name, charset, collation"
  type        = map(map(string))
}

variable "firewall_rules" {
  default     = {}
  description = "Map of firewall rules to create. Key is rule name, values are start_ip, end_ip"
  type        = map(map(string))
}

variable "geo_redundant_backup_enabled" {
  description = "Enable Geo-redundant or not for server backup. Valid values for this property are Enabled or Disabled, not supported for the basic tier."
  type        = bool
  default     = false
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "monitor_action_group_id" {
  default     = ""
  description = "ID of Azure Monitor Action Group for metric to trigger"
  type        = string
}

variable "monitor_metric_alert_criteria" {
  default = {}

  description = <<EOD
Map of name = criteria objects, see these docs for options
https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftdbforpostgresqlservers
EOD

  type = map(object({
    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]
    aggregation = string
    metric_name = string
    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]
    operator  = string
    threshold = number

    dimension = map(object({
      name     = string
      operator = string
      values   = list(string)
    }))
  }))
}

variable "postgresql_configurations" {
  default     = {}
  description = "Map of PostgreSQL configuration settings to create. Key is config name, value is config value"
  type        = map(string)
}

variable "private_endpoint_dns_zone_ids" {
  description = "(Optional) List of resource IDs of DNS zones in which to register the DNS name of the private connection."
  type        = list
  default     = []
}

variable "private_endpoint_enabled" {
  description = "(Optional) Whether or not to create a private endpoint connection for this server. Defaults to false."
  type        = bool
  default     = false
}

variable "private_endpoint_subnet_id" {
  description = "(Optional) Resource ID of subnet that will hold the private endpoint connection."
  type        = string
  default     = ""
}

variable "public_network_access_enabled" {
  description = "(Optional) Whether or not public network access is allowed for this server. Defaults to true."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
}

variable "restore_point_in_time" {
  default     = ""
  description = "(Optional) When create_mode is PointInTimeRestore the point in time to restore from creation_source_server_id. Use ISO8601 format."
  type        = string
}

variable "server_name" {
  description = "Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created. Server name must only contain lowercase letters, numbers, and hyphens. The server name must not start or end in a hyphen. "
  type        = string
}

variable "server_version" {
  default     = "11"
  description = "Specifies the version of PostgreSQL to use. Valid values are 9.5, 9.6, 10, 10.0, and 11. Changing this forces a new resource to be created."
  type        = string
}

variable "sku_name" {
  default     = "B_Gen4_2"
  description = "Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8)."
  type        = string
}

variable "ssl_enforcement_enabled" {
  description = "Specifies if SSL should be enforced on connections."
  type        = bool
  default     = true
}

variable "ssl_minimal_tls_version_enforced" {
  description = "(Optional) The minimum TLS version to support on the sever. Possible values are TLSEnforcementDisabled, TLS1_0, TLS1_1, and TLS1_2. Defaults to TLSEnforcementDisabled."
  type        = string
  default     = "TLSEnforcementDisabled"
}


variable "storage_autogrow" {
  default     = "Enabled"
  description = "Enable/Disable auto-growing of the storage. Valid values for this property are Enabled or Disabled."
  type        = string
}

variable "storage_mb" {
  default     = 5120
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs."
  type        = number
}

variable "tags" {
  default     = {}
  description = "User-Defined tags"
  type        = map(string)
}

variable "vnet_rules" {
  default     = {}
  description = "Map of vnet rules to create. Key is name, value is vnet id"
  type        = map(string)
}
