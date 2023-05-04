# Storage accounts configuration

locals {
  storage_name = "pjtdevmgmtstorage"
}

resource "azurerm_resource_group" "eastus2storagerg" {
  name     = "${var.prefix}-MgmtStorageResources-rg"
  location = "eastus2"
}

resource "azurerm_storage_account" "mgmtstorage" {
  # checkov:skip=CKV2_AZURE_1: Customer managed keys not required, DEV environment.
  # checkov:skip=CKV2_AZURE_18: LOW RISK
  # checkov:skip=CKV_AZURE_206: No replication required. Dev environment.
  # checkov:skip=CKV_AZURE_190: Public network access is disabled
  # checkov:skip=CKV2_AZURE_33: Private endpoint not required. Dev environment.
  # checkov:skip=CKV_AZURE_59: Required for Backend
  name                          = local.storage_name
  resource_group_name           = azurerm_resource_group.eastus2storagerg.name
  location                      = azurerm_resource_group.eastus2storagerg.location
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  public_network_access_enabled = true
  min_tls_version               = "TLS1_2"
  queue_properties {
    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 10
    }
    hour_metrics {
      enabled               = true
      include_apis          = true
      version               = "1.0"
      retention_policy_days = 10
    }
    minute_metrics {
      enabled               = true
      include_apis          = true
      version               = "1.0"
      retention_policy_days = 10
    }
  }
}

resource "azurerm_storage_container" "mgmtscripts" {
  # checkov:skip=CKV2_AZURE_21: LOW RISK
  # checkov:skip=CKV_AZURE_34: Required for Backend
  name                  = "scripts"
  storage_account_name  = azurerm_storage_account.mgmtstorage.name
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "enableipforwarding_ps1" {
  name                   = "enableIpForwarding.ps1"
  storage_account_name   = azurerm_storage_account.mgmtstorage.name
  storage_container_name = azurerm_storage_container.mgmtscripts.name
  type                   = "Block"
  source                 = "ps_scripts/enableIpForwarding.ps1"
}