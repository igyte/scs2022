provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias = "connectivity"
  features {}

  subscription_id = local.subscription_id_connectivity
}

provider "azurerm" {
  alias = "management"
  features {}

  subscription_id = local.subscription_id_management
}
