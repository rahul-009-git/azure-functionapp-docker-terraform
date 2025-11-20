resource "azurerm_log_analytics_workspace" "app_insighs_law" {
  name = "proj1-app-insights-law"
  location = azurerm_resource_group.func_rg.location
  resource_group_name = azurerm_resource_group.func_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 90

  depends_on = [ 
    azurerm_resource_group.func_rg
   ]
}

resource "azurerm_application_insights" "appinsights" {
  name                = "proj1-func-app-insights"
  location            = azurerm_resource_group.func_rg.location
  resource_group_name = azurerm_resource_group.func_rg.name
  application_type    = "web"
  workspace_id = azurerm_log_analytics_workspace.app_insighs_law.id

  tags = {
    environment = "production"
  }

  depends_on = [ 
    azurerm_resource_group.func_rg
   ]
}