# The following locals are used to convert provided input variables to locals 
# before use elsewhere in the module.

locals {
  enable_ddos_protection_plan    = var.enable_ddos_protection_plan
  primary_location               = var.primary_location
  root_id                        = var.root_id
  root_name                      = var.root_name
  secondary_location             = var.secondary_location
  security_contact_email_address = var.security_contact_email_address
  subscription_id_connectivity   = coalesce(var.subscription_id_connectivity, local.subscription_id_management)
  subscription_id_identity       = coalesce(var.subscription_id_identity, local.subscription_id_management)
  subscription_id_management     = coalesce(var.subscription_id_management, data.azurerm_client_config.current.subscription_id)
  subscription_ids_corp          = var.subscription_ids_corp
  subscription_ids_online        = var.subscription_ids_online
}
