# ============================================================
# PASS_prod_env_bypassed.tf
#
# Policy   : AzureFabricSkuValidator
# Scenario : Production environment — policy does not apply
# Expected : PASS (Guard 1 fires `continue`; Guard 2 is never evaluated)
#
# Execution trace:
#   restricted_skus = {"F64"}
#   1. is_non_prod_environment() → False  (prod tag — Guard 1 fires)
#      → assign_generic_block_findings() called, `continue` to next resource
#   2. dereference(config, "sku", "name") is NEVER called for this resource
#   3. construct_overall_success() returned
#
# F64 is used deliberately — if the SKU check were mistakenly evaluated,
# it would fire FAIL. Staying PASS proves the prod bypass is truly unconditional.
#
# ASSUMPTION: is_non_prod_environment() inspects resource_config_data for a
#   "tags" key with an "environment" entry. "production" is not a recognised
#   non-prod token → returns False.
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

data "azurerm_client_config" "pass_prod" {}

# ---------------------------------------------------------------------------
# Supporting resource — resource group
# ---------------------------------------------------------------------------
resource "azurerm_resource_group" "pass_prod_rg" {
  name     = "rg-fabric-pass-prod"
  location = "West Europe"
}

# ---------------------------------------------------------------------------
# Primary resource under test
# ---------------------------------------------------------------------------
resource "azurerm_fabric_capacity" "pass_prod_capacity" {
  name                = "fabricpass-prod"
  resource_group_name = azurerm_resource_group.pass_prod_rg.name
  location            = azurerm_resource_group.pass_prod_rg.location

  administration_members = [data.azurerm_client_config.pass_prod.object_id]

  sku {
    name = "F64"    # ✅ Passes check 2 — SKU check is never reached;
    tier = "Fabric" #   Guard 1 already fired `continue` due to prod environment tag
  }

  tags = {
    environment = "production" # ✅ PASS: is_non_prod_environment() → False
                               #   → assign_generic_block_findings() + `continue` executed
                               #   → SKU value irrelevant; no violation possible
  }
}
