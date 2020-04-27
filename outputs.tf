output "server_name" {
  description = "The name of the PostgreSQL server"
  value       = "${azurerm_postgresql_server.server.name}"
}

output "server_fqdn" {
  description = "The fully qualified domain name (FQDN) of the PostgreSQL server"
  value       = "${azurerm_postgresql_server.server.fqdn}"
}

output "administrator_login" {
  value = "${var.administrator_login}"
}

output "administrator_password" {
  value     = "${var.administrator_password}"
  sensitive = true
}

output "server_id" {
  description = "The resource id of the PostgreSQL server"
  value       = "${azurerm_postgresql_server.server.id}"
}
