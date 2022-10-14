# Configure the custom landing zones to deploy in
# addition the core resource hierarchy.
locals {
  custom_landing_zones = {
    "${local.root_id}-secure" = {
      display_name               = "Secure"
      parent_management_group_id = "${local.root_id}-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id = "customer_secure"
        parameters = {
          Deny-Resource-Locations = {
            listOfAllowedLocations = [
              "uksouth",
              "ukwest",
            ]
          }
          Deny-RSG-Locations = {
            listOfAllowedLocations = [
              "uksouth",
              "ukwest",
            ]
          }
        }
        access_control = {}
      }
    }
  }
}

# Configure the archetype config overrides to customize
# the configuration.
locals {
  archetype_config_overrides = {
    root = {
      archetype_id = "es_root"
      parameters = {
        Deny-Resource-Locations = {
          listOfAllowedLocations = [
            "northeurope",
            "westeurope",
            "uksouth",
            "ukwest",
          ]
        }
        Deny-RSG-Locations = {
          listOfAllowedLocations = [
            "northeurope",
            "westeurope",
            "uksouth",
            "ukwest",
          ]
        }
      }
      access_control = {}
    }
  }
}

# Configure the Subscription ID overrides to ensure
# Subscriptions are moved into the target management
# group.
locals {
  subscription_id_overrides = {
    root           = []
    decommissioned = []
    sandboxes      = [] # Consider whether to duplicate the landing-zones management group hierarchy instead of putting Subscriptions directly in sandboxes.
    landing-zones  = [] # Not recommended, put Subscriptions in child management groups.
    platform       = [] # Not recommended, put Subscriptions in child management groups.
    connectivity   = [] # Not recommended, use subscription_id_connectivity instead.
    management     = [] # Not recommended, use subscription_id_management instead.
    identity       = [] # Not recommended, use subscription_id_identity instead.
    corp           = local.subscription_ids_corp
    online         = local.subscription_ids_online
    sap            = []
    demo-corp      = []
    demo-online    = []
    demo-sap       = []
  }
}
