# basic example
A basic example for this repository

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| db\_configs | n/a | `map` | <pre>{<br>  "timezone": "UTC"<br>}</pre> | no |
| db\_firewall\_rules | n/a | `map` | <pre>{<br>  "AllowAll": {<br>    "end_ip": "255.255.255.255",<br>    "start_ip": "0.0.0.0"<br>  }<br>}</pre> | no |
| db\_names | n/a | `list(string)` | <pre>[<br>  "data-mc-dataface"<br>]</pre> | no |
| location | n/a | `string` | `"eastus"` | no |

## Outputs

| Name | Description |
|------|-------------|
| administrator\_login | n/a |
| administrator\_password | n/a |
| firewall\_rule\_ids | n/a |
| server\_fqdn | n/a |
| server\_name | n/a |
| vnet\_rule\_ids | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
