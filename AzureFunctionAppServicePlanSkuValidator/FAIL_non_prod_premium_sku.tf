# ============================================================
# FAIL_non_prod_premium_sku.tf
#
# Policy   : AzureFunctionAppServicePlanSkuValidator
# Scenario : Non-prod environment + Premium SKU (P1v2)
# Expected : FAIL — prefix "p" matches DEDICATED_SKU_PREFIXES
#
# Execution trace:
#   1. is_non_prod_environment()
#      → get_environment_from_tags() → "environment" = "staging"
#      → NON_PROD_VALUE_PATTERN.match("staging") → True
#      → Guard 1 passes through (no continue)
#   2. dereference(config, "sku_name", default="") → "P1v2"
#      "p1v2".startswith(("b","s","p"))           → True  [prefix "p"]
#      → self.details.append("P1v2")
#      → set_status_and_construct_output(block_file_findings) returned
#
# Default output message:
#   "Dedicated App Service Plan SKU is not permitted in Dev/Test environments.
#    Switch to Consumption (Y1), Elastic Premium (EP1/EP2/EP3), or Flex Consumption (FC1)."
#
# DEDICATED_SKU_PREFIXES prefix exercised: "p" (Premium tier — P1v2, P1v3, P2v2, P2v3, P3v2, P3v3)
# Note: "EP1" (Elastic Premium) starts with "e", NOT "p" — it is explicitly allowed.
#       "P1v2" (Dedicated Premium) starts with "p" — it is forbidden in non-prod.
# Uses "staging" to additionally exercise a third NON_PROD_VALUE_PATTERN token.
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
resource "azurerm_resource_group" "fail_premium_rg" {
  name     = "rg-serviceplan-fail-premium"
  location = "East US"
}

# ---------------------------------------------------------------------------
# Primary resource under test
# ---------------------------------------------------------------------------
resource "azurerm_service_plan" "fail_premium_plan" {
  name                = "asp-fail-premium-staging"
  resource_group_name = azurerm_resource_group.fail_premium_rg.name
  location            = azurerm_resource_group.fail_premium_rg.location
  os_type             = "Linux"

  sku_name = "P1v2" # ❌ FAIL: "p1v2".startswith(("b","s","p")) → True (prefix "p" — Dedicated Premium)
                    #          → self.details.append("P1v2")
                    #          → set_status_and_construct_output() called
                    #
                    # ⚠️  Contrast with EP1 (Elastic Premium, starts with "e") which is ALLOWED.
                    #    P1v2 is Dedicated Premium (VM-backed) — forbidden in non-prod by this policy.

  tags = {
    environment = "staging" # ✅ Passes Guard 1 — NON_PROD_VALUE_PATTERN.match("staging") → True
                            #   proceeds to SKU check
  }
}
