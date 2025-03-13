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

variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Iot Device Provisioning Service resource. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group under which the Iot Device Provisioning Service resource has to be created."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists."
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

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}
