
variable location {
  default = "eastus"
}

variable db_names {
  default = ["data-mc-dataface"]
  type    = list(string)
}

variable db_configs = {
  default = {
    "timezone" = "UTC"
  }
  type    = map
}

variable db_firewall_rules = {
  default = {
    "AllowAll" = {
      start_ip = "0.0.0.0"
      end_ip   = "255.255.255.255"
    },
  }
  type    = map
}
