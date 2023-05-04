variable "resource_group" {
    description = "Object reference to the resouce group where the Virtual Machin will be created"
}
/*
variable "subnet" {
    description = "Object reference to the resouce group where the Virtual Machin will be created"
}
*/

variable "custom_virtual_machine_tags" {
  type        = map(string)
  description = "OPTIONAL: A map of custom tags to apply to the Virtual Machine."
  default     = {}
}

variable "virtual_machines" {
  type = list(object({
    prefix                        = string
    unique_short_name             = string
    size                          = string
    #os_hostname                   = string
    os_type                       = string
    admin_username                = string
    subnet                   = string
    admin_ssh_public_key          = optional(string, null)
    rhel_hybrid_benefit           = optional(bool, false)
    sles_hybrid_benefit           = optional(bool, false)
    windows_client_hybrid_benefit = optional(bool, false)
    windows_server_hybrid_benefit = optional(bool, false)
    encryption_at_host_enabled    = optional(bool, true)
    os_disk_caching               = optional(string, "None")
    os_disk_storage_type          = optional(string, "Premium_LRS")
    os_disk_size_gb               = number
    additional_disks = optional(list(object({
      disk_number       = number
      disk_storage_type = optional(string, "Premium_LRS")
      disk_size_gb      = number
      disk_caching      = optional(string, "None")
    })), [])
    boot_diagnostics_enabled         = optional(bool, true)
    managed_service_identity_enabled = optional(bool, false)
    managed_service_identity_type    = optional(string, "SystemAssigned")
    user_assigned_identity_ids       = optional(list(string), null)
    patch_assessment_mode            = optional(string, "ImageDefault")
    patch_mode                       = optional(string, "AutomaticByOS")
    image_publisher                  = string
    image_offer                      = string
    image_sku                        = string
    image_version                    = string
    backup_policy_name               = string
    backup_included_disk_luns        = optional(list(string))
    backup_excluded_disk_luns        = optional(list(string))
  }))
  default     = []
  description = "List of Virtual Machine objects to be created."
}

variable "vm_admin_password" {
  type        = string
  sensitive   = true
  description = "Admin passwords to use for the project."
}