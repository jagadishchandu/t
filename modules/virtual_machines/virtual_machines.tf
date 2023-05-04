locals {
  additional_disks = flatten([
    for vm in var.virtual_machines : [
      for disk in vm.additional_disks : {
        unique_name          = "${vm.unique_short_name}-${disk.disk_number}"
        disk_number          = disk.disk_number
        disk_caching         = disk.disk_caching
        vm_unique_short_name = vm.unique_short_name
        disk_storage_type    = disk.disk_storage_type
        disk_size_gb         = disk.disk_size_gb
        vm_os_type           = vm.os_type
      }
    ]
  ])
}

resource "azurerm_network_interface" "nic" {
  for_each            = { for vm in var.virtual_machines : vm.unique_short_name => vm }
  name                = "${module.naming.network_interface.name}-${each.value.unique_short_name}"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  tags                = var.custom_virtual_machine_tags
  ip_configuration {
    name                          = "internal"
    subnet_id                     = each.value.subnet #var.subnet
    private_ip_address_allocation = "Dynamic"
  }
  
  lifecycle {
    ignore_changes = [ip_configuration]
  }
}

resource "azurerm_windows_virtual_machine" "windows" {
	# checkov:skip=CKV_AZURE_50: VM extensions required
	# checkov:skip=CKV_AZURE_151: Encryption not required. Dev environment
  # checkov:skip=CKV_AZURE_177: Patching is handled with Intune / Update management center
  for_each                   = { for vm in var.virtual_machines : vm.unique_short_name => vm if vm.os_type == "windows" }
  name                       = "${each.value.prefix}-${module.regions.location_short}-${each.key}"
  #computer_name              = each.value.os_hostname
  resource_group_name        = var.resource_group.name
  location                   = var.resource_group.location
  size                       = each.value.size
  admin_username             = each.value.admin_username
  admin_password             = var.vm_admin_password
  license_type               = each.value.windows_client_hybrid_benefit ? "Windows_Client" : each.value.windows_server_hybrid_benefit ? "Windows_Server" : null
  encryption_at_host_enabled = each.value.encryption_at_host_enabled
  patch_assessment_mode      = each.value.patch_assessment_mode
  patch_mode                 = each.value.patch_mode   
  network_interface_ids      = [azurerm_network_interface.nic[each.key].id]
  provision_vm_agent         = true
  tags                       = var.custom_virtual_machine_tags
  os_disk {
    name                 = "disk-${module.naming.linux_virtual_machine.name}-${each.key}"
    caching              = each.value.os_disk_caching
    storage_account_type = each.value.os_disk_storage_type
    disk_size_gb         = each.value.os_disk_size_gb
  }
  dynamic "boot_diagnostics" {
    for_each = each.value.boot_diagnostics_enabled ? ["diagnostics"] : []
    content {
      storage_account_uri = null
    }
  }
  dynamic "identity" {
    for_each = each.value.managed_service_identity_enabled ? ["identity"] : []
    content {
      type         = each.value.managed_service_identity_type
      identity_ids = each.value.user_assigned_identity_ids
    }
  }
  source_image_reference {
    publisher = each.value.image_publisher
    offer     = each.value.image_offer
    sku       = each.value.image_sku
    version   = each.value.image_version
  }
  lifecycle {
    ignore_changes = [admin_username, admin_password, computer_name]
  }
}

resource "azurerm_managed_disk" "windows_disk" {
	# checkov:skip=CKV_AZURE_93: Not required: Dev environment
  for_each             = { for disk in local.additional_disks : disk.unique_name => disk if disk.vm_os_type == "windows" }
  name                 = "disk-${module.naming.linux_virtual_machine.name}-${each.key}"
  location             = var.resource_group.location
  resource_group_name  = var.resource_group.name
  storage_account_type = each.value.disk_storage_type
  disk_size_gb         = each.value.disk_size_gb
  create_option        = "Empty"
  tags                 = var.custom_virtual_machine_tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "windows_disk_attach" {
  for_each           = { for disk in local.additional_disks : disk.unique_name => disk if disk.vm_os_type == "windows" }
  managed_disk_id    = azurerm_managed_disk.windows_disk[each.key].id
  virtual_machine_id = azurerm_windows_virtual_machine.windows[each.value.vm_unique_short_name].id
  lun                = each.value.disk_number
  caching            = each.value.disk_caching
}
