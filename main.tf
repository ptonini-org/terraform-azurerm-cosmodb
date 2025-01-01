resource "azurerm_cosmosdb_account" "this" {
  name                          = var.name
  location                      = var.rg.location
  resource_group_name           = var.rg.name
  offer_type                    = var.offer_type
  key_vault_key_id              = var.key_vault_key_id
  kind                          = var.kind
  ip_range_filter               = var.ip_range_filter
  public_network_access_enabled = var.public_network_access_enabled

  dynamic "capabilities" {
    for_each = var.capabilities
    content {
      name = capabilities.key
    }
  }

  dynamic "consistency_policy" {
    for_each = var.consistency_policy[*]
    content {
      consistency_level       = consistency_policy.value.consistency_level
      max_interval_in_seconds = consistency_policy.value.max_interval_in_seconds
      max_staleness_prefix    = consistency_policy.value.max_staleness_prefix
    }
  }

  dynamic "geo_location" {
    for_each = var.geo_location[*]
    content {
      location          = coalesce(geo_location.value.location, var.rg.location)
      failover_priority = geo_location.value.failover_priority
      zone_redundant    = geo_location.value.zone_redundant
    }
  }

  dynamic "geo_location" {
    for_each = var.extra_geo_locations
    content {
      location          = geo_location.key
      failover_priority = geo_location.value.failover_priority
      zone_redundant    = geo_location.value.zone_redundant
    }
  }
}