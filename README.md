# tf-azurerm-module_primitive-iothub_dps

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

Manages an Azure Device Provisioning Service.

## Pre-Commit hooks

[.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to terraform, golang and common linting tasks. There are no custom hooks added.

`commitlint` hook enforces commit message in certain format. The commit contains the following structural elements, to communicate intent to the consumers of your commit messages:

- **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
- **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
- **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE:`, or appends a `!` after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
- **build**: a commit of the type `build` adds changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **chore**: a commit of the type `chore` adds changes that don't modify src or test files
- **ci**: a commit of the type `ci` adds changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **docs**: a commit of the type `docs` adds documentation only changes
- **perf**: a commit of the type `perf` adds code change that improves performance
- **refactor**: a commit of the type `refactor` adds code change that neither fixes a bug nor adds a feature
- **revert**: a commit of the type `revert` reverts a previous commit
- **style**: a commit of the type `style` adds code changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: a commit of the type `test` adds missing tests or correcting existing tests

Base configuration used for this project is [commitlint-config-conventional (based on the Angular convention)](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional#type-enum)

If you are a developer using vscode, [this](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint) plugin may be helpful.

`detect-secrets-hook` prevents new secrets from being introduced into the baseline. TODO: INSERT DOC LINK ABOUT HOOKS

In order for `pre-commit` hooks to work properly

- You need to have the pre-commit package manager installed. [Here](https://pre-commit.com/#install) are the installation instructions.
- `pre-commit` would install all the hooks when commit message is added by default except for `commitlint` hook. `commitlint` hook would need to be installed manually using the command below

```
pre-commit install --hook-type commit-msg
```

## To test the resource group module locally

1. For development/enhancements to this module locally, you'll need to install all of its components. This is controlled by the `configure` target in the project's [`Makefile`](./Makefile). Before you can run `configure`, familiarize yourself with the variables in the `Makefile` and ensure they're pointing to the right places.

```
make configure
```

This adds in several files and directories that are ignored by `git`. They expose many new Make targets.

2. _THIS STEP APPLIES ONLY TO MICROSOFT AZURE. IF YOU ARE USING A DIFFERENT PLATFORM PLEASE SKIP THIS STEP._ The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `azure_env.sh` file on local workstation. Devloper would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Service principle used for authentication(value of ARM_CLIENT_ID) should have below privileges on resource group within the subscription.

```
"Microsoft.Resources/subscriptions/resourceGroups/write"
"Microsoft.Resources/subscriptions/resourceGroups/read"
"Microsoft.Resources/subscriptions/resourceGroups/delete"
```

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `azure` specific. If primitive/segment under development uses any other cloud provider than azure, this section may not be relevant.

- A file named `provider.tf` with contents below

```
provider "azurerm" {
  features {}
}
```

- A file named `terraform.tfvars` which contains key value pair of variables used.

Note that since these files are added in `gitignore` they would not be checked in into primitive/segment's git repo.

After creating these files, for running tests associated with the primitive/segment, run

```
make check
```

If `make check` target is successful, developer is good to commit the code to primitive/segment's git repo.

`make check` target

- runs `terraform commands` to `lint`,`validate` and `plan` terraform code.
- runs `conftests`. `conftests` make sure `policy` checks are successful.
- runs `terratest`. This is integration test suit.
- runs `opa` tests
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

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_iothub_dps.dps](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_dps) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the Iot Device Provisioning Service resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group under which the Iot Device Provisioning Service resource has to be created. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resource exists. | `string` | n/a | yes |
| <a name="input_allocation_policy"></a> [allocation\_policy](#input\_allocation\_policy) | (Optional) The allocation policy of the IoT Device Provisioning Service (Hashed, GeoLatency or Static). Defaults to Hashed. | `string` | `"Hashed"` | no |
| <a name="input_data_residency_enabled"></a> [data\_residency\_enabled](#input\_data\_residency\_enabled) | Optional) Specifies if the IoT Device Provisioning Service has data residency and disaster recovery enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Boolean flag to specify whether or not public network access is enabled or not. Defaults to true. | `bool` | `true` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | (Required) The pricing tier for the IoT Device Provisioning Service.<br/>    object({<br/>      name     = (Required) The name of the sku. Currently can only be set to S1.<br/>      capacity = (Required) The number of provisioned IoT Device Provisioning Service units. Currently set to 1.<br/>    }) | <pre>object({<br/>    name     = string<br/>    capacity = number<br/>  })</pre> | <pre>{<br/>  "capacity": 1,<br/>  "name": "S1"<br/>}</pre> | no |
| <a name="input_linked_hubs"></a> [linked\_hubs](#input\_linked\_hubs) | (Optional) A list of iothub objects linked to the Device Provisioning Service. Defaults to an empty list `[]`.<br/>  list(object({<br/>    connection\_string       = (Required) The connection string to connect to the IoT Hub.<br/>    location                = (Required) The location of the IoT hub.<br/>    apply\_allocation\_policy = (Optional) Determines whether to apply allocation policies to the IoT Hub. Defaults to true.<br/>    allocation\_weight       = (Optional) The weight applied to the IoT Hub. Defaults to 1.<br/>  })) | <pre>list(object({<br/>    connection_string       = string<br/>    location                = string<br/>    apply_allocation_policy = optional(bool)<br/>    allocation_weight       = optional(number)<br/>  }))</pre> | `[]` | no |
| <a name="input_ip_filter_rules"></a> [ip\_filter\_rules](#input\_ip\_filter\_rules) | (Optional) A list of ip\_filter\_rule objects. Defaults to an empty list `[]`.<br/>  list(object({<br/>    name    = (Required) The name of the filter.<br/>    ip\_mask = (Required) The IP address range in CIDR notation for the rule.<br/>    action  = (Required) The desired action for requests captured by this rule. Possible values are Accept, Reject<br/>    target  = (Optional) Target for requests captured by this rule. Possible values are all, deviceApi and serviceApi.<br/>  })) | <pre>list(object({<br/>    name    = string<br/>    ip_mask = string<br/>    action  = string<br/>    target  = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Device Provisioning Service Id. |
| <a name="output_name"></a> [name](#output\_name) | The Device Provisioning Service Name. |
| <a name="output_id_scope"></a> [id\_scope](#output\_id\_scope) | The Device Provisioning Service Id Scope. |
| <a name="output_device_provisioning_host_name"></a> [device\_provisioning\_host\_name](#output\_device\_provisioning\_host\_name) | The Device Provisioning Service Device Provisioning Host Name. |
| <a name="output_service_operations_host_name"></a> [service\_operations\_host\_name](#output\_service\_operations\_host\_name) | The Device Provisioning Service Service Operations Host Name. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
