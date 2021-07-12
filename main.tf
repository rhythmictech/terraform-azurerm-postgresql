
resource "azurerm_postgresql_server" "server" {
  name                             = lower(var.server_name)
  administrator_login              = var.administrator_login
  administrator_login_password     = var.administrator_password
  auto_grow_enabled                = var.auto_grow_enabled
  backup_retention_days            = var.backup_retention_days
  geo_redundant_backup_enabled     = var.geo_redundant_backup_enabled
  location                         = var.location
  public_network_access_enabled    = var.public_network_access_enabled
  resource_group_name              = var.resource_group_name
  sku_name                         = var.sku_name
  ssl_enforcement_enabled          = var.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = var.ssl_minimal_tls_version_enforced
  storage_mb                       = var.storage_mb
  tags                             = var.tags
  version                          = var.server_version
}

resource "azurerm_postgresql_database" "database" {
  for_each = var.dbs

  name                = each.value.name
  charset             = lookup(each.value, "charset", "UTF8")
  collation           = lookup(each.value, "collation", "en_US.utf8")
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
}

resource "azurerm_postgresql_firewall_rule" "firewall_rule" {
  for_each = var.firewall_rules

  name                = each.key
  end_ip_address      = each.value.end_ip
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
  start_ip_address    = each.value.start_ip
}

resource "azurerm_postgresql_virtual_network_rule" "vnet_rule" {
  for_each = var.vnet_rules

  name                = each.key
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
  subnet_id           = each.value
}

resource "azurerm_postgresql_configuration" "config" {
  for_each = var.postgresql_configurations

  name                = each.key
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
  value               = each.value
}

########################################
# Private Endpoint
########################################
resource "azurerm_private_endpoint" "endpoint" {
  count = var.private_endpoint_enabled ? 1 : 0

  name                = "${var.server_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_dns_zone_group {
    name                 = "privatelink_postgres"
    private_dns_zone_ids = var.private_endpoint_dns_zone_ids
  }

  private_service_connection {
    name                           = "${var.server_name}-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_postgresql_server.server.id
    subresource_names              = ["postgresqlServer"]
  }
}


########################################
# Monitoring
########################################

resource "azurerm_monitor_metric_alert" "this" {
  for_each = var.monitor_metric_alert_criteria

  name                = "${var.server_name}-${upper(each.key)}"
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
