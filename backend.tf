terraform {
  backend "azurerm" {
    storage_account_name = "pjtdevnovastorage"
    container_name       = "terraform-state"
    key                  = "pjtdev-resources.tfstate"
  }
}