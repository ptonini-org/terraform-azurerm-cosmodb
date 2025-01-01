variable "name" {}

variable "rg" {
  type = object({
    name     = string
    location = string
  })
}

variable "offer_type" {
  default  = "Standard"
  nullable = false
}

variable "kind" {
  default  = "GlobalDocumentDB"
  nullable = false
}

variable "key_vault_key_id" {
  default = null
}

variable "ip_range_filter" {
  default = null
}

variable "public_network_access_enabled" {
  default = true
  nullable = false
}

variable "capabilities" {
  type = set(string)
  default = []
  nullable = false
}

variable "consistency_policy" {
  type = object({
    consistency_level       = optional(string, "Session")
    max_interval_in_seconds = optional(number, 5)
    max_staleness_prefix    = optional(number, 100)
  })
  default  = {}
  nullable = false
}

variable "geo_location" {
  type = object({
    location          = optional(string)
    failover_priority = optional(number, 0)
    zone_redundant    = optional(bool, false)
  })
  default  = {}
  nullable = false
}

variable "extra_geo_locations" {
  type = map(object({
    failover_priority = number
    zone_redundant    = optional(bool, false)
  }))
  default  = {}
  nullable = false
}

