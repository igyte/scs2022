# Configure the connectivity resources settings.
# This input contains additional logic to optionally:
# - Deploy a hub network in the secondary location
# - Enable deployment of a DDoS Protection Standard plan and link it to hub networks
locals {
  configure_connectivity_resources = {
    settings = {
      hub_networks = flatten([
        [{
          enabled = true
          config = {
            address_space                = ["10.100.0.0/22", ]
            location                     = local.primary_location
            link_to_ddos_protection_plan = local.enable_ddos_protection_plan
            dns_servers                  = []
            bgp_community                = ""
            subnets                      = []
            virtual_network_gateway = {
              enabled = true
              config = {
                address_prefix           = "10.100.1.0/24"
                gateway_sku_expressroute = ""
                gateway_sku_vpn          = "VpnGw2AZ"
                advanced_vpn_settings = {
                  enable_bgp                       = true
                  active_active                    = true
                  private_ip_address_allocation    = "Dynamic"
                  default_local_network_gateway_id = ""
                  vpn_client_configuration         = []
                  bgp_settings                     = []
                  custom_route                     = []
                }
              }
            }
            azure_firewall = {
              enabled = true
              config = {
                address_prefix                = "10.100.0.0/24"
                enable_dns_proxy              = true
                dns_servers                   = []
                sku_tier                      = ""
                base_policy_id                = ""
                private_ip_ranges             = []
                threat_intelligence_mode      = ""
                threat_intelligence_allowlist = []
                availability_zones = {
                  zone_1 = true
                  zone_2 = true
                  zone_3 = true
                }
              }
            }
            spoke_virtual_network_resource_ids      = []
            enable_outbound_virtual_network_peering = true
            enable_hub_network_mesh_peering         = true
          }
        }],
        local.secondary_location != "" ? [{
          enabled = true
          config = {
            address_space                = ["10.101.0.0/22", ]
            location                     = local.secondary_location
            link_to_ddos_protection_plan = local.enable_ddos_protection_plan
            dns_servers                  = []
            bgp_community                = ""
            subnets                      = []
            virtual_network_gateway = {
              enabled = false
              config = {
                address_prefix           = "10.101.1.0/24"
                gateway_sku_expressroute = "ErGw1AZ"
                gateway_sku_vpn          = "VpnGw2AZ"
                advanced_vpn_settings = {
                  enable_bgp                       = null
                  active_active                    = null
                  private_ip_address_allocation    = ""
                  default_local_network_gateway_id = ""
                  vpn_client_configuration         = []
                  bgp_settings                     = []
                  custom_route                     = []
                }
              }
            }
            azure_firewall = {
              enabled = false
              config = {
                address_prefix                = "10.101.0.0/24"
                enable_dns_proxy              = true
                dns_servers                   = []
                sku_tier                      = ""
                base_policy_id                = ""
                private_ip_ranges             = []
                threat_intelligence_mode      = ""
                threat_intelligence_allowlist = []
                availability_zones = {
                  zone_1 = true
                  zone_2 = true
                  zone_3 = true
                }
              }
            }
            spoke_virtual_network_resource_ids      = []
            enable_outbound_virtual_network_peering = true
            enable_hub_network_mesh_peering         = true
          }
        }] : []
      ])
      vwan_hub_networks = []
      ddos_protection_plan = {
        enabled = local.enable_ddos_protection_plan
        config = {
          location = ""
        }
      }
      dns = {
        enabled = true
        config = {
          location = null
          enable_private_link_by_service = {
            azure_automation_webhook             = true
            azure_automation_dscandhybridworker  = true
            azure_sql_database_sqlserver         = true
            azure_synapse_analytics_sqlserver    = true
            azure_synapse_analytics_sql          = true
            storage_account_blob                 = true
            storage_account_table                = true
            storage_account_queue                = true
            storage_account_file                 = true
            storage_account_web                  = true
            azure_data_lake_file_system_gen2     = true
            azure_cosmos_db_sql                  = true
            azure_cosmos_db_mongodb              = true
            azure_cosmos_db_cassandra            = true
            azure_cosmos_db_gremlin              = true
            azure_cosmos_db_table                = true
            azure_database_for_postgresql_server = true
            azure_database_for_mysql_server      = true
            azure_database_for_mariadb_server    = true
            azure_key_vault                      = true
            azure_kubernetes_service_management  = true
            azure_search_service                 = true
            azure_container_registry             = true
            azure_app_configuration_stores       = true
            azure_backup                         = true
            azure_site_recovery                  = true
            azure_event_hubs_namespace           = true
            azure_service_bus_namespace          = true
            azure_iot_hub                        = true
            azure_relay_namespace                = true
            azure_event_grid_topic               = true
            azure_event_grid_domain              = true
            azure_web_apps_sites                 = true
            azure_machine_learning_workspace     = true
            signalr                              = true
            azure_monitor                        = true
            cognitive_services_account           = true
            azure_file_sync                      = true
            azure_data_factory                   = true
            azure_data_factory_portal            = true
            azure_cache_for_redis                = true
          }
          private_link_locations                                 = []
          public_dns_zones                                       = []
          private_dns_zones                                      = []
          enable_private_dns_zone_virtual_network_link_on_hubs   = true
          enable_private_dns_zone_virtual_network_link_on_spokes = true
        }
      }
    }
    location = null
    tags     = null
    advanced = null
  }
}