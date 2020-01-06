# terraform-azurerm-postgresql
[![](https://github.com/rhythmictech/terraform-azurerm-postgresql/workflows/check/badge.svg)](https://github.com/rhythmictech/terraform-azurerm-postgresql/actions)

Terraform module for Azure managed PostgreSQL Database

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| administrator\_login | The Administrator Login for the PostgreSQL Server. Changing this forces a new resource to be created. | string | n/a | yes |
| administrator\_password | The Password associated with the administrator\_login for the PostgreSQL Server. | string | n/a | yes |
| backup\_retention\_days | Backup retention days for the server, supported values are between 7 and 35 days. | number | `"7"` | no |
| db\_charset | Specifies the Charset for the PostgreSQL Database, which needs to be a valid PostgreSQL Charset. Changing this forces a new resource to be created. | string | `"UTF8"` | no |
| db\_collation | Specifies the Collation for the PostgreSQL Database, which needs to be a valid PostgreSQL Collation. Note that Microsoft uses different notation - en-US instead of en\_US. Changing this forces a new resource to be created. | string | `"English_United States.1252"` | no |
| db\_names | The list of names of the PostgreSQL Database, which needs to be a valid PostgreSQL identifier. Changing this forces a new resource to be created. | list(string) | `[]` | no |
| env | Environment to tag resources with | string | `"default"` | no |
| firewall\_rule\_prefix | Specifies prefix for firewall rule names. | string | `"firewall-"` | no |
| firewall\_rules | The list of maps, describing firewall rules. Valid map items: name, start\_ip, end\_ip. | list(map(string)) | `[]` | no |
| geo\_redundant\_backup | Enable Geo-redundant or not for server backup. Valid values for this property are Enabled or Disabled, not supported for the basic tier. | string | `"Disabled"` | no |
| location | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | string | n/a | yes |
| name | Moniker to apply to all resources in the module | string | n/a | yes |
| postgresql\_configurations | A map with PostgreSQL configurations to enable. | map(string) | `{}` | no |
| resource\_group\_name | The name of the resource group in which to create the PostgreSQL Server. Changing this forces a new resource to be created. | string | n/a | yes |
| server\_name | Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created. | string | n/a | yes |
| server\_version | Specifies the version of PostgreSQL to use. Valid values are 9.5, 9.6, and 10.0. Changing this forces a new resource to be created. | string | `"9.5"` | no |
| sku\_capacity | The scale up/out capacity, representing server's compute units | string | `"2"` | no |
| sku\_family | The family of hardware Gen4 or Gen5. | string | `"Gen4"` | no |
| sku\_name | Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern \(e.g. B\_Gen4\_1, GP\_Gen5\_8\). | string | `"B_Gen4_2"` | no |
| sku\_tier | The tier of the particular SKU. Possible values are Basic, GeneralPurpose, and MemoryOptimized. | string | `"Basic"` | no |
| ssl\_enforcement | Specifies if SSL should be enforced on connections. Possible values are Enabled and Disabled. | string | `"Enabled"` | no |
| storage\_mb | Max storage allowed for a server. Possible values are between 5120 MB\(5GB\) and 1048576 MB\(1TB\) for the Basic SKU and between 5120 MB\(5GB\) and 4194304 MB\(4TB\) for General Purpose/Memory Optimized SKUs. | number | `"5120"` | no |
| tags | User-Defined tags | map(string) | `{}` | no |
| vnet\_rule\_name\_prefix | Specifies prefix for vnet rule names. | string | `"postgresql-vnet-rule-"` | no |
| vnet\_rules | The list of maps, describing vnet rules. Valud map items: name, subnet\_id. | list(map(string)) | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| administrator\_login |  |
| administrator\_password |  |
| database\_ids | The list of all database resource ids |
| firewall\_rule\_ids | The list of all firewall rule resource ids |
| server\_fqdn | The fully qualified domain name \(FQDN\) of the PostgreSQL server |
| server\_id | The resource id of the PostgreSQL server |
| server\_name | The name of the PostgreSQL server |
| vnet\_rule\_ids | The list of all vnet rule resource ids |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
