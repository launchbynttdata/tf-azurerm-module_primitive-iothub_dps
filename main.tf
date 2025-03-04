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

resource "azurerm_iothub_dps" "dps" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  public_network_access_enabled = var.public_network_access_enabled

  sku {
    name     = var.sku_name
    capacity = var.sku_capacity
  }

  dynamic "linked_hub" {
    for_each = var.iothub_instances != null ? var.iothub_instances : []
    content {
      connection_string = linked_hub.value.connection_string
      location          = linked_hub.value.location
    }
  }

  tags = local.tags
}
