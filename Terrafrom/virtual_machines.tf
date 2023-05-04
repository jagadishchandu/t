resource "azurerm_resource_group" "eastus2servers" {
  name     = "${var.prefix}-ue2-servers-${module.naming.resource_group.name}"
  location = "eastus2"
}

module "virtual_machines" {
  source = "./modules/virtual_machines"

  resource_group = azurerm_resource_group.eastus2servers

  virtual_machines = [
    {
      prefix            = "srv"
      unique_short_name = "okta1"
      size              = "Standard_B2s"
      subnet            = data.azurerm_subnet.eastus2servers.id
      os_type           = "windows"
      #os_hostname                = "okta1"
      admin_username             = var.server-admin-user
      encryption_at_host_enabled = false
      os_disk_storage_type       = "Standard_LRS"
      os_disk_size_gb            = 127
      image_publisher            = "MicrosoftWindowsServer"
      patch_assessment_mode      = "AutomaticByPlatform"
      patch_mode                 = "AutomaticByPlatform"
      image_offer                = "WindowsServer"
      image_sku                  = "2022-datacenter-azure-edition"
      image_version              = "latest"
      backup_policy_name         = "DailyBackupRetain30Days"
    },
    {
      prefix            = "srv"
      unique_short_name = "adsyn1"
      size              = "Standard_B2s"
      subnet            = data.azurerm_subnet.eastus2servers.id
      os_type           = "windows"
      #os_hostname                = "adsyn1"
      admin_username             = var.server-admin-user
      encryption_at_host_enabled = false
      os_disk_storage_type       = "Standard_LRS"
      os_disk_size_gb            = 127
      image_publisher            = "MicrosoftWindowsServer"
      patch_assessment_mode      = "AutomaticByPlatform"
      patch_mode                 = "AutomaticByPlatform"
      image_offer                = "WindowsServer"
      image_sku                  = "2019-datacenter"
      image_version              = "latest"
      backup_policy_name         = "DailyBackupRetain30Days"
    },
    {
      prefix            = "srv"
      unique_short_name = "adprov1"
      size              = "Standard_B2s"
      subnet            = data.azurerm_subnet.eastus2servers.id
      os_type           = "windows"
      #os_hostname                = "adprov1"
      admin_username             = var.server-admin-user
      encryption_at_host_enabled = false
      os_disk_storage_type       = "Standard_LRS"
      os_disk_size_gb            = 127
      image_publisher            = "MicrosoftWindowsServer"
      patch_assessment_mode      = "AutomaticByPlatform"
      patch_mode                 = "AutomaticByPlatform"
      image_offer                = "WindowsServer"
      image_sku                  = "2022-datacenter-azure-edition"
      image_version              = "latest"
      backup_policy_name         = "DailyBackupRetain30Days"
    },
    {
      prefix                     = "srv"
      unique_short_name          = "snow"
      size                       = "Standard_B4ms"
      subnet                     = data.azurerm_subnet.eastus2servers.id
      os_type                    = "windows"
      admin_username             = var.server-admin-user
      encryption_at_host_enabled = false
      os_disk_storage_type       = "Standard_LRS"
      os_disk_size_gb            = 127
      image_publisher            = "MicrosoftWindowsServer"
      patch_assessment_mode      = "AutomaticByPlatform"
      patch_mode                 = "AutomaticByPlatform"
      image_offer                = "WindowsServer"
      image_sku                  = "2022-datacenter-azure-edition"
      image_version              = "latest"
      backup_policy_name         = "DailyBackupRetain30Days"
    },
    {
      prefix                     = "srv"
      unique_short_name          = "ca"
      size                       = "Standard_B2s"
      subnet                     = data.azurerm_subnet.eastus2servers.id
      os_type                    = "windows"
      admin_username             = var.server-admin-user
      encryption_at_host_enabled = false
      os_disk_storage_type       = "Standard_LRS"
      os_disk_size_gb            = 127
      image_publisher            = "MicrosoftWindowsServer"
      patch_assessment_mode      = "AutomaticByPlatform"
      patch_mode                 = "AutomaticByPlatform"
      image_offer                = "WindowsServer"
      image_sku                  = "2012-R2-Datacenter"
      image_version              = "latest"
      backup_policy_name         = "DailyBackupRetain30Days"
    },
    {
      prefix                     = "srv"
      unique_short_name          = "app1q"
      size                       = "Standard_B2s"
      subnet                     = data.azurerm_subnet.eastus2servers.id
      os_type                    = "windows"
      admin_username             = var.server-admin-user
      encryption_at_host_enabled = false
      os_disk_storage_type       = "Standard_LRS"
      os_disk_size_gb            = 127
      image_publisher            = "MicrosoftWindowsServer"
      patch_assessment_mode      = "AutomaticByPlatform"
      patch_mode                 = "AutomaticByPlatform"
      image_offer                = "WindowsServer"
      image_sku                  = "2012-R2-Datacenter"
      image_version              = "latest"
      backup_policy_name         = "DailyBackupRetain30Days"
    },
    {
      prefix                     = "srv"
      unique_short_name          = "adselfs"
      size                       = "Standard_B2ms"
      subnet                     = data.azurerm_subnet.eastus2servers.id
      os_type                    = "windows"
      admin_username             = var.server-admin-user
      encryption_at_host_enabled = false
      os_disk_storage_type       = "Standard_LRS"
      os_disk_size_gb            = 127
      image_publisher            = "MicrosoftWindowsServer"
      patch_assessment_mode      = "AutomaticByPlatform"
      patch_mode                 = "AutomaticByPlatform"
      image_offer                = "WindowsServer"
      image_sku                  = "2022-datacenter-azure-edition"
      image_version              = "latest"
      backup_policy_name         = "DailyBackupRetain30Days"
    },
    {
      prefix                     = "srv"
      unique_short_name          = "mabs1"
      size                       = "Standard_B2ms"
      subnet                     = data.azurerm_subnet.eastus2servers.id
      os_type                    = "windows"
      admin_username             = var.server-admin-user
      encryption_at_host_enabled = false
      os_disk_storage_type       = "Standard_LRS"
      os_disk_size_gb            = 127
      additional_disks = [
        {
          disk_number       = 1
          disk_storage_type = "Standard_LRS"
          disk_size_gb      = 100
        },
      ]
      image_publisher            = "MicrosoftWindowsServer"
      patch_assessment_mode      = "AutomaticByPlatform"
      patch_mode                 = "AutomaticByPlatform"
      image_offer                = "WindowsServer"
      image_sku                  = "2022-datacenter-azure-edition"
      image_version              = "latest"
      backup_policy_name         = "DailyBackupRetain30Days"
    },
  ]
  vm_admin_password           = var.server-admin-password
  custom_virtual_machine_tags = { "patching" : "azure", "patchingschedule" : "ue2-weekly-autorestart" }
}
