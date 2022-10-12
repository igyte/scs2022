# The demo deployment has been segregated into 3 instances
# of the caf-enterprise-scale module to demonstrate how
# resource creation can be split across multiple workspaces.

module "alz_core" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "2.4.1"

  providers = {
    azurerm              = azurerm.management
    azurerm.connectivity = azurerm.connectivity
    azurerm.management   = azurerm.management
  }

  # Base module configuration settings
  root_parent_id   = data.azurerm_client_config.management.tenant_id
  root_id          = local.root_id
  root_name        = local.root_name
  default_location = local.primary_location

  # Disable strict subscription association
  strict_subscription_association = false

  # Configuration settings for optional landing zones
  deploy_corp_landing_zones   = true
  deploy_online_landing_zones = true
  deploy_sap_landing_zones    = false

  # Configure path for custom library folder
  library_path = "${path.root}/lib"

  # Configuration settings for core resources
  deploy_core_landing_zones  = true
  custom_landing_zones       = local.custom_landing_zones
  archetype_config_overrides = local.archetype_config_overrides
  subscription_id_overrides  = local.subscription_id_overrides

  # Configuration settings for connectivity resources
  deploy_connectivity_resources    = false
  configure_connectivity_resources = local.configure_connectivity_resources
  subscription_id_connectivity     = data.azurerm_client_config.connectivity.subscription_id

  # Configuration settings for identity resources
  deploy_identity_resources    = true
  configure_identity_resources = local.configure_identity_resources
  subscription_id_identity     = local.subscription_id_identity

  # Configuration settings for management resources
  deploy_management_resources    = false
  configure_management_resources = local.configure_management_resources
  subscription_id_management     = data.azurerm_client_config.management.subscription_id

}

module "alz_connectivity" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "2.4.1"

  providers = {
    azurerm              = azurerm.management
    azurerm.connectivity = azurerm.connectivity
    azurerm.management   = azurerm.management
  }

  # Base module configuration settings
  root_parent_id   = data.azurerm_client_config.management.tenant_id
  root_id          = local.root_id
  root_name        = local.root_name
  default_location = local.primary_location

  # Configuration settings for core resources
  deploy_core_landing_zones = false

  # Configuration settings for connectivity resources
  deploy_connectivity_resources    = true
  configure_connectivity_resources = local.configure_connectivity_resources
  subscription_id_connectivity     = data.azurerm_client_config.connectivity.subscription_id
}

module "alz_management" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "2.4.1"

  providers = {
    azurerm              = azurerm.management
    azurerm.connectivity = azurerm.connectivity
    azurerm.management   = azurerm.management
  }

  # Base module configuration settings
  root_parent_id   = data.azurerm_client_config.management.tenant_id
  root_id          = local.root_id
  root_name        = local.root_name
  default_location = local.primary_location

  # Configuration settings for core resources
  deploy_core_landing_zones = false

  # Configuration settings for management resources
  deploy_management_resources    = true
  configure_management_resources = local.configure_management_resources
  subscription_id_management     = data.azurerm_client_config.management.subscription_id
}
