
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

  name        = "toothfairy"
  env         = "test"
  server_name = "postgresql${random_id.name.hex}"
  sku_name    = "GP_Gen5_2"

  storage_mb            = 5120
  backup_retention_days = 7
  geo_redundant_backup  = "Disabled"

  administrator_login    = "azureuser"
  administrator_password = "Azur3us3r!"

  server_version  = "11"
  ssl_enforcement = "Enabled"

  dbs                       = var.db_names
  firewall_rules            = var.db_firewall_rules
  postgresql_configurations = var.db_config
}
