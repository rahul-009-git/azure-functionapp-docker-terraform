

resource "azurerm_service_plan" "func_asp" {
  name                = "${var.asp_name}-asp"
  resource_group_name = azurerm_resource_group.func_rg.name
  location            = azurerm_resource_group.func_rg.location
  os_type = "Linux"

  //reserved = true
    sku_name = "P1v3"
  depends_on = [ 
    azurerm_resource_group.func_rg
   ]
}