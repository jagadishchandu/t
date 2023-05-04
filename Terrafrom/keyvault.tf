# Azure Keyvault resources. Do not delete.
resource "azurerm_resource_group" "kv1rg" {
  name     = "${var.prefix}-vmKeyVault-rg"
  location = "eastus2"
}

resource "azurerm_key_vault" "kv1" {
  # checkov:skip=CKV2_AZURE_32: Private endpoint not required. Dev environment
  # checkov:skip=CKV_AZURE_189: Public access required for DevOps
  # checkov:skip=CKV_AZURE_109: Public access required for DevOps
  name                          = "${var.prefix}-vmsecrets"
  location                      = azurerm_resource_group.kv1rg.location
  resource_group_name           = azurerm_resource_group.kv1rg.name
  enabled_for_disk_encryption   = true
  tenant_id                     = data.azurerm_client_config.core.tenant_id
  soft_delete_retention_days    = 7
  purge_protection_enabled      = true
  public_network_access_enabled = true
  sku_name                      = "standard"
  access_policy {
    tenant_id = data.azurerm_client_config.core.tenant_id
    object_id = data.azurerm_client_config.core.object_id
    key_permissions = [
      "Get",
    ]
    secret_permissions = [
      "Get", "Backup", "Delete", "List", "Purge", "Recover", "Restore", "Set",
    ]
    storage_permissions = [
      "Get",
    ]
  }
  access_policy {
    tenant_id = data.azurerm_client_config.core.tenant_id
    object_id = "d84c47f3-2444-4f17-949a-a973aabc1e22"
    key_permissions = [
      "Get",
    ]
    secret_permissions = [
      "Get", "Backup", "Delete", "List", "Purge", "Recover", "Restore", "Set",
    ]
    storage_permissions = [
      "Get",
    ]
  }
  /*
  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
  }
  */
}