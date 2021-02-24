# terraform-azurerm-postgresql
[![](https://github.com/rhythmictech/terraform-azurerm-postgresql/workflows/check/badge.svg)](https://github.com/rhythmictech/terraform-azurerm-postgresql/actions)

Terraform module for Azure managed PostgreSQL Database

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| azurerm | >=1.40.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >=1.40.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| administrator\_login | The Administrator Login for the PostgreSQL Server. Changing this forces a new resource to be created. | `string` | n/a | yes |
| administrator\_password | The Password associated with the administrator\_login for the PostgreSQL Server. | `string` | n/a | yes |
| location | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| resource\_group\_name | The name of the resource group in which to create the PostgreSQL Server. Changing this forces a new resource to be created. | `string` | n/a | yes |
| server\_name | Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created. Server name must only contain lowercase letters, numbers, and hyphens. The server name must not start or end in a hyphen. | `string` | n/a | yes |
| backup\_retention\_days | Backup retention days for the server, supported values are between 7 and 35 days. | `number` | `7` | no |
| dbs | Map of databases to create, values supported: name, charset, collation | `map` | `{}` | no |
| firewall\_rules | Map of firewall rules to create. Key is rule name, values are start\_ip, end\_ip | `map` | `{}` | no |
| geo\_redundant\_backup | Enable Geo-redundant or not for server backup. Valid values for this property are Enabled or Disabled, not supported for the basic tier. | `string` | `"Disabled"` | no |
| monitor\_action\_group\_id | ID of Azure Monitor Action Group for metric to trigger | `string` | `""` | no |
| monitor\_metric\_alert\_criteria | Map of name = criteria objects, see these docs for options<br>https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftdbforpostgresqlservers | <pre>map(object({<br>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br>    aggregation = string<br>    metric_name = string<br>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br>    operator  = string<br>    threshold = number<br><br>    dimension = map(object({<br>      name     = string<br>      operator = string<br>      values   = list(string)<br>    }))<br>  }))</pre> | `{}` | no |
| postgresql\_configurations | Map of PostgreSQL configuration settings to create. Key is config name, value is config value | `map` | `{}` | no |
| server\_version | Specifies the version of PostgreSQL to use. Valid values are 9.5, 9.6, 10, 10.0, and 11. Changing this forces a new resource to be created. | `string` | `"11"` | no |
| sku\_name | Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B\_Gen4\_1, GP\_Gen5\_8). | `string` | `"B_Gen4_2"` | no |
| ssl\_enforcement | Specifies if SSL should be enforced on connections. Possible values are Enabled and Disabled. | `string` | `"Enabled"` | no |
| storage\_autogrow | Enable/Disable auto-growing of the storage. Valid values for this property are Enabled or Disabled. | `string` | `"Enabled"` | no |
| storage\_mb | Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs. | `number` | `5120` | no |
| tags | User-Defined tags | `map(string)` | `{}` | no |
| vnet\_rules | Map of vnet rules to create. Key is name, value is vnet id | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| administrator\_login | Admin username |
| administrator\_password | Password for admin user |
| server\_fqdn | The fully qualified domain name (FQDN) of the PostgreSQL server |
| server\_id | The resource id of the PostgreSQL server |
| server\_name | The name of the PostgreSQL server |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
