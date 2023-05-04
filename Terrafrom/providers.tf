# Configure terraform provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.41.0"
      configuration_aliases = [
        azurerm.connectivity,
        azurerm.management,
      ]
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  client_id       = var.spn_client_id
  client_secret   = var.spn_client_secret
  tenant_id       = var.spn_tenant_id
  subscription_id = var.core_subscription_id
}

# This will be used for the deployment of all "Connectivity resources" to the specified `subscription_id`.
provider "azurerm" {
  alias = "connectivity"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  client_id       = var.spn_client_id
  client_secret   = var.spn_client_secret
  tenant_id       = var.spn_tenant_id
  subscription_id = var.connectivity_subscription_id
}

# This will be used for the deployment of all "Management resources" to the specified `subscription_id`.
provider "azurerm" {
  alias = "management"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  client_id       = var.spn_client_id
  client_secret   = var.spn_client_secret
  tenant_id       = var.spn_tenant_id
  subscription_id = var.management_subscription_id
}

# This will be used for the deployment of all "Identity resources" to the specified `subscription_id`.
provider "azurerm" {
  alias = "identity"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  client_id       = var.spn_client_id
  client_secret   = var.spn_client_secret
  tenant_id       = var.spn_tenant_id
  subscription_id = var.identity_subscription_id
}
