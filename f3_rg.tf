resource "azurerm_resource_group" "func_rg" {
  location = var.rg_location
  name = var.rg_name

  tags = {
  environment = "dev"
  owner = "rahul"
  }
}

