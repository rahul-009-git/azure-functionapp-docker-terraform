resource "azurerm_linux_function_app" "func-app" {
  name                = "${var.func_name}-func-app"
  resource_group_name = azurerm_resource_group.func_rg.name
  location            = azurerm_resource_group.func_rg.location

  storage_account_name       = azurerm_storage_account.func_storage.name
  //storage_account_access_key = azurerm_storage_account.func_storage.primary_access_key
  service_plan_id            = azurerm_service_plan.func_asp.id

  storage_uses_managed_identity = true

    identity {
      type = "SystemAssigned"
    
    }
  site_config {
    always_on = true
    application_stack {
      python_version = "3.10"
    }
  }

  app_settings = {
    # --- General Function App Settings ---
    "FUNCTIONS_EXTENSION_VERSION" = "~4",
    "FUNCTIONS_WORKER_RUNTIME"    = "python", # Match your application_stack

    # --- Application Insights Configuration ---
    # Use the connection string for App Insights
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.appinsights.connection_string,
    
    # --- Storage Configuration (Managed Identity) ---
    # Instead of a connection string, we provide the account name.
    # The "__accountName" suffix tells the Functions runtime to use
    # Managed Identity for this storage connection.
    "AzureWebJobsStorage__accountName" = azurerm_storage_account.func_storage.name
  }

  # Depends on App Insights so the connection string is available
  depends_on = [
    azurerm_application_insights.appinsights,
  ]
}

# Assign Storage Blob Data Contributor role to the function's managed identity
# so the function can access blobs using MSI.
resource "azurerm_role_assignment" "func_storage_blob_data_contributor" {
  scope                = azurerm_storage_account.func_storage.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_linux_function_app.func-app.identity[0].principal_id

  # role assignment name must be unique per scope & principal
  depends_on = [azurerm_linux_function_app.func-app]
}