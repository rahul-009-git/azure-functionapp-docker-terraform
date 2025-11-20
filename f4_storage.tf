resource "random_string" "storage_name" {
  length = 6
  upper = false
  special = false
  numeric = false
}

resource "azurerm_storage_account" "func_storage" {
  name = random_string.storage_name.result
  resource_group_name = azurerm_resource_group.func_rg.name
  location = azurerm_resource_group.func_rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  public_network_access_enabled = false         # No public network access
  shared_access_key_enabled      = false         # No key-based auth allowed
  allow_nested_items_to_be_public = false       # No public blob access
  

  tags = {
    environment = "staging"
  }
}

