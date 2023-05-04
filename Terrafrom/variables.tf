# Variables for the Azure provider connection. These need to be passed as variables in the terraform command line
variable "spn_client_id" {}
variable "spn_client_secret" {}
variable "spn_tenant_id" {}

# Available subscriptions in PJT DEV
# 4ed3fccf-f19b-4181-bde2-f48b7ad78b9f PJTDEV-Terraform
# 78ad1daf-a982-4579-81ed-b53cd5a9b1ac PJTDEV-identity
# cb74e0b9-be49-4dc3-913d-9df6baa41b0f PJTDEV-Sandbox

variable "core_subscription_id" {
  type        = string
  default     = "4ed3fccf-f19b-4181-bde2-f48b7ad78b9f"
  description = "Subscription ID to use for the unaliased azurerm provider"
}

variable "connectivity_subscription_id" {
  type        = string
  default     = "4ed3fccf-f19b-4181-bde2-f48b7ad78b9f"
  description = "Subscription ID where connectivity resources will be deployed"
}

variable "management_subscription_id" {
  type        = string
  default     = "4ed3fccf-f19b-4181-bde2-f48b7ad78b9f"
  description = "Subscription ID where management resources will be deployed"
}

variable "identity_subscription_id" {
  type        = string
  default     = "4ed3fccf-f19b-4181-bde2-f48b7ad78b9f"
  description = "Subscription ID where identity resources will be deployed"
}

variable "prefix" {
  type        = string
  default     = "PJTDEV"
  description = "Prefix of the name for deployed resources"
}