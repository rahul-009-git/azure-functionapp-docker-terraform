terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = ">= 4.47"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5"
    }
    
  }
}

provider "azurerm" {
  features {
    
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "7caf822d-bc7b-4a80-99ca-122918a7c090"
  storage_use_azuread = true
}