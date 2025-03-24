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

output "id" {
  description = "The Device Provisioning Service Id."
  value       = azurerm_iothub_dps.dps.id
}

output "name" {
  description = "The Device Provisioning Service Name."
  value       = azurerm_iothub_dps.dps.name
}

output "id_scope" {
  description = "The Device Provisioning Service Id Scope."
  value       = azurerm_iothub_dps.dps.id_scope
}

output "device_provisioning_host_name" {
  description = "The Device Provisioning Service Device Provisioning Host Name."
  value       = azurerm_iothub_dps.dps.device_provisioning_host_name

}

output "service_operations_host_name" {
  description = "The Device Provisioning Service Service Operations Host Name."
  value       = azurerm_iothub_dps.dps.service_operations_host_name
}
