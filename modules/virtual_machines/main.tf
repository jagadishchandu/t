terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.41.0"
    }
  }
}

module "regions" {
  source  = "claranet/regions/azurerm"
  version = "6.1.0"

  azure_region = var.resource_group.location
}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.2.0"

  suffix = ["${module.regions.location_short}"]
}
