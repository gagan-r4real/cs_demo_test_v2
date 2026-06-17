locals {
  #redis_cache_name        = "${var.redis_cache_name}-${var.environment}-${var.project_name}-${var.redis_cache_location}-${var.instance}"
  managed_redis_cache_name = "${var.amr_name}-${var.environment}-${var.project_name}-${var.redis_cache_location}-${var.instance}"
}

# # This resource block creates an Azure Redis Cache with specified configurations.
# resource "azurerm_redis_cache" "tf_redis_cache" {
#   name                = local.redis_cache_name
#   location            = var.redis_cache_location
#   resource_group_name = azurerm_resource_group.temp_dr_resource_group.name
#   capacity            = 3
#   family              = "P"
#   sku_name            = "Premium"
#   minimum_tls_version = "1.2"
#   tags                = var.tags
#   identity {
#     type = "SystemAssigned"
#   }
#   depends_on = [
#     azurerm_resource_group.temp_dr_resource_group
#   ]
# }


resource "azurerm_managed_redis" "tf_managed_redis_cache" {
    name                = local.managed_redis_cache_name
    resource_group_name = azurerm_resource_group.temp_dr_resource_group.name
    location            = azurerm_resource_group.temp_dr_resource_group.location
    sku_name            = "Balanced_B20"

    identity {
      type = "SystemAssigned"
    }

    default_database {
      geo_replication_group_name = "${var.environment}-geo-group"
    }

    tags = var.tags
}