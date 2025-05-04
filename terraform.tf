terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.27.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.105.0"
    }
  }

  cloud {
    organization = "az-env"
    workspaces {
      name = "aks-app"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  resource_provider_registrations = "extended"
}