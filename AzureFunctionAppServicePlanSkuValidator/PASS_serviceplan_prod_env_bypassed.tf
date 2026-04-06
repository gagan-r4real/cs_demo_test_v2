# ============================================================
# PASS_serviceplan_prod_env_bypassed.tf
#
# Policy   : AzureFunctionAppServicePlanSkuValidator
# Scenario : Production environment — policy does not apply
# Expected : PASS (Guard 1 fires `continue`; Guard 2 is never evaluated)
#
# Execution trace:
#   1. is_non_prod_environment()
#      → get_environment_from_tags() scans tags{} for ENV_KEY_PATTERN → "environment" = "production"
#      → NON_PROD_VALUE_PATTERN.match("production") → False
#        (PROD_VALUE_PATTERN matches instead: "prod(uction)?")
#      → Guard 1 fires: assign_generic_block_findings() + `continue`
#   2. dereference(config, "sku_name") is NEVER called for this resource
#   3. construct_overall_success() returned
#
# B1 (Basic) is used deliberately — if the SKU check were mistakenly
# evaluated it would fire FAIL, proving the prod bypass is unconditional.
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

# ---------------------------------------------------------------------------
# Supporting resource — resource group
# ---------------------------------------------------------------------------
resource "azurerm_resource_group" "pass_sp_prod_rg" {
  name     = "rg-serviceplan-pass-prod"
  location = "East US"
}

# ---------------------------------------------------------------------------
# Primary resource under test
# ---------------------------------------------------------------------------
resource "azurerm_service_plan" "pass_sp_prod_plan" {
  name                = "asp-pass-prod-basic"
  resource_group_name = azurerm_resource_group.pass_sp_prod_rg.name
  location            = azurerm_resource_group.pass_sp_prod_rg.location
  os_type             = "Linux"

  sku_name = "B1" # ✅ Passes check 2 — SKU check is never reached;
                  #   Guard 1 already fired `continue` due to prod environment tag
                  #   (deliberately a DEDICATED SKU to prove bypass is unconditional)

  tags = {
    environment = "production" # ✅ PASS: ENV_KEY_PATTERN matches "environment"
                               #          NON_PROD_VALUE_PATTERN.match("production") → False
                               #          → assign_generic_block_findings() + `continue` executed
  }
}
