# tf-azurerm-module_primitive-log_analytics_workspace

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.117 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform.registry.launch.nttdata.com/module_primitive/resource_group/azurerm | ~> 1.0 |
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 2.0 |
| <a name="module_device_provisioning_service"></a> [device\_provisioning\_service](#module\_device\_provisioning\_service) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_iothub.iothub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | `"eastus"` | no |
| <a name="input_allocation_policy"></a> [allocation\_policy](#input\_allocation\_policy) | (Optional) The allocation policy of the IoT Device Provisioning Service (Hashed, GeoLatency or Static). Defaults to Hashed. | `string` | `"Hashed"` | no |
| <a name="input_data_residency_enabled"></a> [data\_residency\_enabled](#input\_data\_residency\_enabled) | Optional) Specifies if the IoT Device Provisioning Service has data residency and disaster recovery enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Boolean flag to specify whether or not public network access is enabled or not. Defaults to true. | `bool` | `true` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | (Required) The pricing tier for the IoT Device Provisioning Service.<br/>    object({<br/>      name     = (Required) The name of the sku. Currently can only be set to S1.<br/>      capacity = (Required) The number of provisioned IoT Device Provisioning Service units. Currently set to 1.<br/>    }) | <pre>object({<br/>    name     = string<br/>    capacity = number<br/>  })</pre> | <pre>{<br/>  "capacity": 1,<br/>  "name": "S1"<br/>}</pre> | no |
| <a name="input_linked_hubs"></a> [linked\_hubs](#input\_linked\_hubs) | (Optional) A list of iothub objects linked to the Device Provisioning Service. Defaults to an empty list `[]`.<br/>  list(object({<br/>    connection\_string       = (Required) The connection string to connect to the IoT Hub.<br/>    location                = (Required) The location of the IoT hub.<br/>    apply\_allocation\_policy = (Optional) Determines whether to apply allocation policies to the IoT Hub. Defaults to true.<br/>    allocation\_weight       = (Optional) The weight applied to the IoT Hub. Defaults to 1.<br/>  })) | <pre>list(object({<br/>    connection_string       = string<br/>    location                = string<br/>    apply_allocation_policy = optional(bool)<br/>    allocation_weight       = optional(number)<br/>  }))</pre> | `[]` | no |
| <a name="input_ip_filter_rules"></a> [ip\_filter\_rules](#input\_ip\_filter\_rules) | (Optional) A list of ip\_filter\_rule objects. Defaults to an empty list `[]`.<br/>  list(object({<br/>    name    = (Required) The name of the filter.<br/>    ip\_mask = (Required) The IP address range in CIDR notation for the rule.<br/>    action  = (Required) The desired action for requests captured by this rule. Possible values are Accept, Reject<br/>    target  = (Optional) Target for requests captured by this rule. Possible values are all, deviceApi and serviceApi.<br/>  })) | <pre>list(object({<br/>    name    = string<br/>    ip_mask = string<br/>    action  = string<br/>    target  = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object({<br/>    name       = string<br/>    max_length = optional(number, 60)<br/>    region     = optional(string, "eastus")<br/>  }))</pre> | <pre>{<br/>  "device_provisioning_service": {<br/>    "max_length": 80,<br/>    "name": "dps"<br/>  },<br/>  "iothub": {<br/>    "max_length": 80,<br/>    "name": "iothub"<br/>  },<br/>  "resource_group": {<br/>    "max_length": 80,<br/>    "name": "rg"<br/>  }<br/>}</pre> | no |
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `0` | no |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `0` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | Name of the product family for which the resource is created. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | Name of the product service for which the resource is created. | `string` | `"dps"` | no |
| <a name="input_class_env"></a> [class\_env](#input\_class\_env) | Environment where resource is going to be deployed. For example. dev, qa, uat | `string` | `"dev"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Device Provisioning Service Id. |
| <a name="output_name"></a> [name](#output\_name) | The Device Provisioning Service Name. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The Resource Group Name. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
