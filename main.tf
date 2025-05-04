# Azure Verified Modules
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "~> 0.4.2"

  suffix = [var.suffix_workload]
}

# Resource Group with Azure Verified Module
module "rg" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.2.1"

  name     = module.naming.resource_group.name
  location = var.location
}