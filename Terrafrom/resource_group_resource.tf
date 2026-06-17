locals {
    resource_group_name = "${var.resource_group_name}-${var.environment}-${var.project_name}-${var.location}-${var.instance}"
    temp_dr_resource_group_name = "${var.resource_group_name}-${var.environment}-${var.project_name}-${var.redis_cache_location}-${var.instance}"
}

resource "azurerm_resource_group" "tf_resource_group" {
    name     = local.resource_group_name
    location = var.location

    tags     = var.tags
}

locals {
  flatten_resource_group_roles = flatten([
    for principal_ids in var.resource_group_role_assignments : [
      for pid in principal_ids.principal_id : {
        principal_id = pid
        role_name    = principal_ids.role_name
      }
    ]
  ])
}


# This resource block Assigns permissions to vendor group on the resoruce group.
resource "azurerm_role_assignment" "tf_resource_group_rbac" {
  for_each = {for ids, val in local.flatten_resource_group_roles : "${val.principal_id}-${val.role_name}" => val}
  scope                = azurerm_resource_group.tf_resource_group.id
 role_definition_name = each.value.role_name
  principal_id         = each.value.principal_id

  depends_on = [ azurerm_resource_group.tf_resource_group ]
}


resource "azurerm_resource_group" "temp_dr_resource_group" {
    name = local.temp_dr_resource_group_name
    location = var.redis_cache_location

    tags     = var.tags
}

resource "azurerm_role_assignment" "temp_resource_group_rbac" {
  for_each = {for ids, val in local.flatten_resource_group_roles : "dr-${val.principal_id}-${val.role_name}" => val}
  scope                = azurerm_resource_group.temp_dr_resource_group.id
  role_definition_name = each.value.role_name
  principal_id         = each.value.principal_id

  depends_on = [ azurerm_resource_group.temp_dr_resource_group ]
}
