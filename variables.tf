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
  description = "(Required) Specifies the name of the device provisioning service."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which the device provisioning service is created."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists."
}

variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Boolean flag to specify whether or not public network access is enabled or not. Defaults to true."
  default     = true
}

variable "sku_name" {
  type        = string
  description = "(Optional) Specifies the SKU of the device provisioning service. Possible values are S1, S2, and S3. Defaults to S1."
  default     = "S1"
}

variable "sku_capacity" {
  type        = number
  description = "(Optional) Specifies the number of units in the specified SKU. Defaults to 1."
  default     = 1
}

variable "iothub_instances" {
  type = list(object({
    connection_string = string
    location          = string
  }))
  description = "(Optional) A list of objects containing the connection string and location of the linked IoT Hub. Defaults to an empty list `[]`."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}
