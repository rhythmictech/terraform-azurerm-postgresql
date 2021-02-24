variable "administrator_login" {
  description = "The Administrator Login for the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
}

variable "administrator_password" {
  description = "The Password associated with the administrator_login for the PostgreSQL Server."
  type        = string
}

variable "backup_retention_days" {
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
  type        = number
  default     = 7
}

variable "dbs" {
  description = "Map of databases to create, values supported: name, charset, collation"
  type        = map(map(string))
  default     = {}
}

variable "firewall_rules" {
  description = "Map of firewall rules to create. Key is rule name, values are start_ip, end_ip"
  type        = map(map(string))
  default     = {}
}

variable "geo_redundant_backup" {
  description = "Enable Geo-redundant or not for server backup. Valid values for this property are Enabled or Disabled, not supported for the basic tier."
  type        = string
  default     = "Disabled"
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
  description = "Map of PostgreSQL configuration settings to create. Key is config name, value is config value"
  type        = map(string)
  default     = {}
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
}

variable "server_name" {
  description = "Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created. Server name must only contain lowercase letters, numbers, and hyphens. The server name must not start or end in a hyphen. "
  type        = string
}

variable "server_version" {
  description = "Specifies the version of PostgreSQL to use. Valid values are 9.5, 9.6, 10, 10.0, and 11. Changing this forces a new resource to be created."
  type        = string
  default     = "11"
}

variable "sku_name" {
  description = "Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8)."
  type        = string
  default     = "B_Gen4_2"
}

variable "ssl_enforcement" {
  description = "Specifies if SSL should be enforced on connections. Possible values are Enabled and Disabled."
  type        = string
  default     = "Enabled"
}

variable "storage_autogrow" {
  description = "Enable/Disable auto-growing of the storage. Valid values for this property are Enabled or Disabled."
  type        = string
  default     = "Enabled"
}

variable "storage_mb" {
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs."
  type        = number
  default     = 5120
}

variable "tags" {
  description = "User-Defined tags"
  type        = map(string)
  default     = {}
}

variable "vnet_rules" {
  description = "Map of vnet rules to create. Key is name, value is vnet id"
  type        = map(string)
  default     = {}
}
