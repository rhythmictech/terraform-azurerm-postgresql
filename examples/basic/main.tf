variable location {
  default = "eastus"
}

variable db_names {
  default = ["data-mc-dataface"]
  type    = list(string)
}

# variable "fw_rule_prefix" {
#   type = list(string)
# }

# variable fw_rules {
#   type = list(string)
# }

# =========================================

provider "random" {}

resource "random_id" "name" {
  byte_length = 8
}

resource "azurerm_resource_group" "test" {
  name     = "test${random_id.name.hex}"
  location = var.location
}

module "postgresql" {
  source = "../../"

  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location

  name         = "toothfairy"
  env          = "test"
  server_name  = "postgresql${random_id.name.hex}"
  sku_name     = "GP_Gen5_2"
  sku_capacity = 2
  sku_tier     = "GeneralPurpose"
  sku_family   = "Gen5"

  storage_mb            = 5120
  backup_retention_days = 7
  geo_redundant_backup  = "Disabled"

  administrator_login    = "azureuser"
  administrator_password = "Azur3us3r!"

  server_version  = "9.5"
  ssl_enforcement = "Enabled"

  db_names     = var.db_names
  db_charset   = "UTF8"
  db_collation = "English_United States.1252"

  #   firewall_rules       = var.fw_rules
}

# =========================================

output "server_name" {
  value = module.postgresql.server_name
}

output "server_fqdn" {
  value = module.postgresql.server_fqdn
}

output "administrator_login" {
  value = module.postgresql.administrator_login
}

output "administrator_password" {
  value     = module.postgresql.administrator_password
  sensitive = true
}

output "firewall_rule_ids" {
  value = module.postgresql.firewall_rule_ids
}

output "vnet_rule_ids" {
  value = module.postgresql.vnet_rule_ids
}
