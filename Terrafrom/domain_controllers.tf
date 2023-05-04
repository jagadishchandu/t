resource "azurerm_resource_group" "eastus2dcs" {
  name     = "${var.prefix}-ue2-dcs-${module.naming.resource_group.name}"
  location = "eastus2"
}

module "domain_controllers_ue2" {
  source = "./modules/virtual_machines"

  resource_group = azurerm_resource_group.eastus2dcs

  virtual_machines = [
    {
      prefix            = "srv"
      unique_short_name = "dc1"
      size              = "Standard_B2s"
      subnet            = data.azurerm_subnet.eastus2servers.id
      os_type           = "windows"
      #os_hostname                = "dc1"
      admin_username             = var.dc-admin-user
      encryption_at_host_enabled = false
      os_disk_storage_type       = "Standard_LRS"
      os_disk_size_gb            = 127
      additional_disks = [
        {
          disk_number       = 1
          disk_storage_type = "Premium_LRS"
          disk_size_gb      = 4
        },
      ]
      image_publisher       = "MicrosoftWindowsServer"
      patch_assessment_mode = "AutomaticByPlatform"
      patch_mode            = "AutomaticByPlatform"
      image_offer           = "WindowsServer"
      image_sku             = "2022-datacenter-azure-edition"
      image_version         = "latest"
      backup_policy_name    = "DailyBackupRetain30Days"
    },
  ]
  vm_admin_password           = var.dc-admin-password
  custom_virtual_machine_tags = { "patching" : "azure", "patchingschedule" : "ue2-weekly-autorestart" }
}

resource "azurerm_resource_group" "uksouthdcs" {
  name     = "${var.prefix}-uks-dcs-${module.naming.resource_group.name}"
  location = "uksouth"
}

module "domain_controllers_uks" {
  source = "./modules/virtual_machines"

  resource_group = azurerm_resource_group.uksouthdcs

  virtual_machines = [
    {
      prefix            = "srv"
      unique_short_name = "dc1"
      size              = "Standard_B2s"
      subnet            = data.azurerm_subnet.uksouthservers.id
      os_type           = "windows"
      #os_hostname                = "dc1"
      admin_username             = var.dc-admin-user
      encryption_at_host_enabled = false
      os_disk_storage_type       = "Standard_LRS"
      os_disk_size_gb            = 127
      additional_disks = [
        {
          disk_number       = 1
          disk_storage_type = "Premium_LRS"
          disk_size_gb      = 4
        },
      ]
      image_publisher       = "MicrosoftWindowsServer"
      patch_assessment_mode = "AutomaticByPlatform"
      patch_mode            = "AutomaticByPlatform"
      image_offer           = "WindowsServer"
      image_sku             = "2022-datacenter-azure-edition"
      image_version         = "latest"
      backup_policy_name    = "DailyBackupRetain30Days"
    },
  ]
  vm_admin_password           = var.dc-admin-password
  custom_virtual_machine_tags = { "patching" : "azure", "patchingschedule" : "uks-weekly-autorestart" }
}