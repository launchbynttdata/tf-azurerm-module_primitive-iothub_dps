// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = "eastus"
}

variable "allocation_policy" {
  type        = string
  description = "(Optional) The allocation policy of the IoT Device Provisioning Service (Hashed, GeoLatency or Static). Defaults to Hashed."
  validation {
    condition     = contains(["Hashed", "GeoLatency", "Static"], var.allocation_policy)
    error_message = "Allocation policy must be one of Hashed, GeoLatency or Static."
  }
  default = "Hashed"
}

variable "data_residency_enabled" {
  type        = bool
  description = "Optional) Specifies if the IoT Device Provisioning Service has data residency and disaster recovery enabled. Defaults to false."
  default     = false
}

variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Boolean flag to specify whether or not public network access is enabled or not. Defaults to true."
  default     = true
}

variable "sku" {
  description = <<EOF
  (Required) The pricing tier for the IoT Device Provisioning Service.
    object({
      name     = (Required) The name of the sku. Currently can only be set to S1.
      capacity = (Required) The number of provisioned IoT Device Provisioning Service units. Currently set to 1.
    })
  EOF
  type = object({
    name     = string
    capacity = number
  })
  default = {
    name     = "S1"
    capacity = 1
  }
}

variable "linked_hubs" {
  description = <<EOF
  (Optional) A list of iothub objects linked to the Device Provisioning Service. Defaults to an empty list `[]`.
  list(object({
    connection_string       = (Required) The connection string to connect to the IoT Hub.
    location                = (Required) The location of the IoT hub.
    apply_allocation_policy = (Optional) Determines whether to apply allocation policies to the IoT Hub. Defaults to true.
    allocation_weight       = (Optional) The weight applied to the IoT Hub. Defaults to 1.
  }))
  EOF
  type = list(object({
    connection_string       = string
    location                = string
    apply_allocation_policy = optional(bool)
    allocation_weight       = optional(number)
  }))
  default = []
}

variable "ip_filter_rules" {
  description = <<EOF
  (Optional) A list of ip_filter_rule objects. Defaults to an empty list `[]`.
  list(object({
    name    = (Required) The name of the filter.
    ip_mask = (Required) The IP address range in CIDR notation for the rule.
    action  = (Required) The desired action for requests captured by this rule. Possible values are Accept, Reject
    target  = (Optional) Target for requests captured by this rule. Possible values are all, deviceApi and serviceApi.
  }))
  EOF
  type = list(object({
    name    = string
    ip_mask = string
    action  = string
    target  = optional(string)
  }))
  default = []
}

//variables required by resource names module
variable "resource_names_map" {
  description = "A map of key to resource_name that will be used by tf-launch-module_library-resource_name to generate resource names"
  type = map(object({
    name       = string
    max_length = optional(number, 60)
    region     = optional(string, "eastus")
  }))

  default = {
    resource_group = {
      name       = "rg"
      max_length = 80
    }
    device_provisioning_service = {
      name       = "dps"
      max_length = 80
    }
    iothub = {
      name       = "iothub"
      max_length = 80
    }
  }
}

variable "instance_env" {
  type        = number
  description = "Number that represents the instance of the environment."
  default     = 0
}

variable "instance_resource" {
  type        = number
  description = "Number that represents the instance of the resource."
  default     = 0
}

variable "logical_product_family" {
  type        = string
  description = "Name of the product family for which the resource is created."
  default     = "launch"
}

variable "logical_product_service" {
  type        = string
  description = "Name of the product service for which the resource is created."

  default = "dps"
}

variable "class_env" {
  type        = string
  description = "Environment where resource is going to be deployed. For example. dev, qa, uat"
  default     = "dev"
}
