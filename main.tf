
terraform {
  required_version = ">= 0.12.21"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 1.40"
    }
  }
}

resource "azurerm_postgresql_server" "server" {
  name                = lower(var.server_name)
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_password
  sku_name                     = var.sku_name
  ssl_enforcement              = var.ssl_enforcement
  version                      = var.server_version

  storage_profile {
    auto_grow             = var.storage_autogrow
    backup_retention_days = var.backup_retention_days
    geo_redundant_backup  = var.geo_redundant_backup
    storage_mb            = var.storage_mb
  }

  tags = var.tags
}

resource "azurerm_postgresql_database" "database" {
  for_each = var.dbs

  charset             = lookup(each.value, "charset", "UTF8")
  collation           = lookup(each.value, "collation", "en_US.utf8")
  name                = each.value.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
}

resource "azurerm_postgresql_firewall_rule" "firewall_rule" {
  for_each = var.firewall_rules

  name                = each.key
  start_ip_address    = each.value.start_ip
  end_ip_address      = each.value.end_ip
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
}

resource "azurerm_postgresql_virtual_network_rule" "vnet_rule" {
  for_each = var.vnet_rules

  name                = each.key
  subnet_id           = each.value
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
}

resource "azurerm_postgresql_configuration" "config" {
  for_each = var.postgresql_configurations

  name                = each.key
  value               = each.value
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
}

########################################
# Monitoring
########################################

resource "azurerm_monitor_metric_alert" "this" {
  for_each = var.monitor_metric_alert_criteria

  name                = "${var.name}-${upper(each.key)}"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_postgresql_server.server.id]
  tags                = var.tags

  action {
    action_group_id = var.monitor_action_group_id
  }

  criteria {
    aggregation      = each.value.aggregation
    metric_namespace = "Microsoft.DBforPostgreSQL/servers"
    metric_name      = each.value.metric_name
    operator         = each.value.operator
    threshold        = each.value.threshold

    dynamic "dimension" {
      for_each = each.value.dimension
      content {
        name     = dimension.value.name
        operator = dimension.value.operator
        values   = dimension.value.value
      }
    }
  }
}
