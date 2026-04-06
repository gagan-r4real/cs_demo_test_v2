# ============================================================
# PASS_non_prod_allowed_sku.tf
#
# Policy   : AzureFabricSkuValidator
# Scenario : Non-prod environment + SKU not in restricted_skus
# Expected : PASS — neither guard triggers a violation
#
# Execution trace:
#   restricted_skus = {"F64"}
#   1. is_non_prod_environment() → True  (dev tag — Guard 1 passes through)
#   2. dereference(config, "sku", "name") → "F2"
#      "F2" in {"F64"}             → False  (Guard 2 not triggered)
#   3. assign_generic_block_findings() → construct_overall_success()
#
# SKU path resolution:
#   utils.dereference(config, "sku", "name") walks config["sku"]["name"].
#   The provider exposes `sku` as a single-instance HCL block; the policy
#   engine stores single-instance blocks as dicts, so no integer index is
#   needed between "sku" and "name".
#
# ASSUMPTION: is_non_prod_environment() inspects resource_config_data for a
#   "tags" key with an "environment" entry whose value is a recognised
#   non-prod token (dev / test / staging / nonprod / qa).
# ============================================================

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "pass_allowed" {}

# ---------------------------------------------------------------------------
# Supporting resource — resource group
# ---------------------------------------------------------------------------
resource "azurerm_resource_group" "pass_allowed_rg" {
  name     = "rg-fabric-pass-allowed"
  location = "West Europe"
}

# ---------------------------------------------------------------------------
# Primary resource under test
# ---------------------------------------------------------------------------
resource "azurerm_fabric_capacity" "pass_allowed_capacity" {
  name                = "fabricpass-allowed"
  resource_group_name = azurerm_resource_group.pass_allowed_rg.name
  location            = azurerm_resource_group.pass_allowed_rg.location

  administration_members = [data.azurerm_client_config.pass_allowed.object_id]

  sku {
    name = "F2"   # ✅ PASS: dereference(config, "sku", "name") → "F2"
    tier = "Fabric" #         "F2" ∉ {"F64"} → Guard 2 not triggered
  }

  tags = {
    environment = "dev" # ✅ PASS: is_non_prod_environment() → True — Guard 1 passes through to SKU check
  }
}
