# ============================================================
# FAIL_non_prod_restricted_sku.tf
#
# Policy   : AzureFabricSkuValidator
# Scenario : Non-prod environment + SKU in restricted_skus
# Expected : FAIL — set_status_and_construct_output() called
#
# Execution trace:
#   restricted_skus = {"F64"}
#   1. is_non_prod_environment() → True  (dev tag — Guard 1 passes through)
#   2. dereference(config, "sku", "name") → "F64"
#      "F64" in {"F64"}            → True   (Guard 2 triggers FAIL)
#      → self.details.append("F64")
#      → set_status_and_construct_output(findings) returned
#
# Default output message:
#   "The selected Fabric SKU is not allowed for this environment."
#
# SKU path resolution:
#   utils.dereference(config, "sku", "name") walks config["sku"]["name"].
#   The provider exposes `sku` as a single-instance HCL block stored as a
#   dict by the policy engine — no integer index between "sku" and "name".
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

data "azurerm_client_config" "fail_restricted" {}

# ---------------------------------------------------------------------------
# Supporting resource — resource group
# ---------------------------------------------------------------------------
resource "azurerm_resource_group" "fail_restricted_rg" {
  name     = "rg-fabric-fail-restricted"
  location = "West Europe"
}

# ---------------------------------------------------------------------------
# Primary resource under test
# ---------------------------------------------------------------------------
resource "azurerm_fabric_capacity" "fail_restricted_capacity" {
  name                = "fabricfail-restricted"
  resource_group_name = azurerm_resource_group.fail_restricted_rg.name
  location            = azurerm_resource_group.fail_restricted_rg.location

  administration_members = [data.azurerm_client_config.fail_restricted.object_id]

  sku {
    name = "F64"    # ❌ FAIL: dereference(config, "sku", "name") → "F64"
    tier = "Fabric" #          "F64" ∈ {"F64"} → Guard 2 triggered
                    #          → self.details.append("F64")
                    #          → set_status_and_construct_output() called
  }

  tags = {
    environment = "dev" # ✅ Passes Guard 1 — is_non_prod_environment() → True, proceeds to SKU check
  }
}
