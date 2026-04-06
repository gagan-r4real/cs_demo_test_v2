# ============================================================
# FAIL_serviceplan_non_prod_standard_sku.tf
#
# Policy   : AzureFunctionAppServicePlanSkuValidator
# Scenario : Non-prod environment + Standard SKU (S1)
# Expected : FAIL — prefix "s" matches DEDICATED_SKU_PREFIXES
#
# Execution trace:
#   1. is_non_prod_environment()
#      → get_environment_from_tags() → "environment" = "test"
#      → NON_PROD_VALUE_PATTERN.match("test") → True
#      → Guard 1 passes through (no continue)
#   2. dereference(config, "sku_name", default="") → "S1"
#      "s1".startswith(("b","s","p"))             → True  [prefix "s"]
#      → self.details.append("S1")
#      → set_status_and_construct_output(block_file_findings) returned
#
# Default output message:
#   "Dedicated App Service Plan SKU is not permitted in Dev/Test environments.
#    Switch to Consumption (Y1), Elastic Premium (EP1/EP2/EP3), or Flex Consumption (FC1)."
#
# DEDICATED_SKU_PREFIXES prefix exercised: "s" (Standard tier — S1, S2, S3)
# Uses "test" to additionally exercise an alternative NON_PROD_VALUE_PATTERN token.
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
resource "azurerm_resource_group" "fail_std_sp_rg" {
  name     = "rg-serviceplan-fail-standard"
  location = "East US"
}

# ---------------------------------------------------------------------------
# Primary resource under test
# ---------------------------------------------------------------------------
resource "azurerm_service_plan" "fail_std_sp_plan" {
  name                = "asp-fail-standard-test"
  resource_group_name = azurerm_resource_group.fail_std_sp_rg.name
  location            = azurerm_resource_group.fail_std_sp_rg.location
  os_type             = "Linux"

  sku_name = "S1" # ❌ FAIL: "s1".startswith(("b","s","p")) → True (prefix "s" — Standard tier)
                  #          → self.details.append("S1")
                  #          → set_status_and_construct_output() called

  tags = {
    environment = "test" # ✅ Passes Guard 1 — NON_PROD_VALUE_PATTERN.match("test") → True
                         #   proceeds to SKU check
  }
}
