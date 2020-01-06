variable "name" {
  description = "Moniker to apply to all resources in the module"
  type        = string
}

variable "tags" {
  description = "User-Defined tags"
  type        = map(string)
  default     = {}
}

variable "env" {
  description = "Environment to tag resources with"
  type        = string
  default     = "default"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "server_name" {
  description = "Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
}

variable "sku_name" {
  description = "Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8)."
  type        = string
  default     = "B_Gen4_2"
}

variable "sku_capacity" {
  description = "The scale up/out capacity, representing server's compute units"
  type        = string
  default     = "2"
}

variable "sku_tier" {
  description = "The tier of the particular SKU. Possible values are Basic, GeneralPurpose, and MemoryOptimized."
  type        = string
  default     = "Basic"
}

variable "sku_family" {
  description = " The family of hardware Gen4 or Gen5."
  type        = string
  default     = "Gen4"
}

variable "storage_mb" {
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs."
  type        = number
  default     = 5120
}

variable "backup_retention_days" {
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
  type        = number
  default     = 7
}

variable "geo_redundant_backup" {
  description = "Enable Geo-redundant or not for server backup. Valid values for this property are Enabled or Disabled, not supported for the basic tier."
  type        = string
  default     = "Disabled"
}

variable "administrator_login" {
  description = "The Administrator Login for the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
}

variable "administrator_password" {
  description = "The Password associated with the administrator_login for the PostgreSQL Server."
  type        = string
}

variable "server_version" {
  description = "Specifies the version of PostgreSQL to use. Valid values are 9.5, 9.6, and 10.0. Changing this forces a new resource to be created."
  type        = string
  default     = "9.5"
}

variable "ssl_enforcement" {
  description = "Specifies if SSL should be enforced on connections. Possible values are Enabled and Disabled."
  type        = string
  default     = "Enabled"
}

variable "db_names" {
  description = "The list of names of the PostgreSQL Database, which needs to be a valid PostgreSQL identifier. Changing this forces a new resource to be created."
  type        = list(string)
  default     = []
}

variable "db_charset" {
  description = "Specifies the Charset for the PostgreSQL Database, which needs to be a valid PostgreSQL Charset. Changing this forces a new resource to be created."
  type        = string
  default     = "UTF8"
}

variable "db_collation" {
  description = "Specifies the Collation for the PostgreSQL Database, which needs to be a valid PostgreSQL Collation. Note that Microsoft uses different notation - en-US instead of en_US. Changing this forces a new resource to be created."
  type        = string
  default     = "English_United States.1252"
}

variable "firewall_rule_prefix" {
  description = "Specifies prefix for firewall rule names."
  type        = string
  default     = "firewall-"
}

variable "firewall_rules" {
  description = "The list of maps, describing firewall rules. Valid map items: name, start_ip, end_ip."
  type        = list(map(string))
  default     = []
}

variable "vnet_rule_name_prefix" {
  description = "Specifies prefix for vnet rule names."
  type        = string
  default     = "postgresql-vnet-rule-"
}

variable "vnet_rules" {
  description = "The list of maps, describing vnet rules. Valud map items: name, subnet_id."
  type        = list(map(string))
  default     = []
}

variable "postgresql_configurations" {
  description = "A map with PostgreSQL configurations to enable."
  type        = map(string)
  default     = {}
}
