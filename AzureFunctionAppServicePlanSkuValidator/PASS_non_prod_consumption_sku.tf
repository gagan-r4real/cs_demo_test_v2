# ============================================================
# PASS_non_prod_consumption_sku.tf
#
# Policy   : AzureFunctionAppServicePlanSkuValidator
# Scenario : Non-prod environment + Consumption SKU (Y1)
# Expected : PASS — neither guard fires a violation
#
# Execution trace:
#   1. is_non_prod_environment()
#      → get_environment_from_tags() scans tags{} for ENV_KEY_PATTERN
#        ("env|environment|envr|environmenttype") → matches "environment" = "dev"
#      → NON_PROD_VALUE_PATTERN.match("dev") → True
#      → Guard 1 passes through (no continue)
#   2. dereference(config, "sku_name", default="") → "Y1"
#      "y1".startswith(("b","s","p"))            → False
#      → Guard 2 not triggered
#   3. assign_generic_block_findings() → construct_overall_success()
#
# "Y1" starts with "y" — outside DEDICATED_SKU_PREFIXES ("b","s","p").
# Consumption plan is the recommended serverless alternative for Function Apps.
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
resource "azurerm_resource_group" "pass_consumption_rg" {
  name     = "rg-serviceplan-pass-consumption"
  location = "East US"
}

# ---------------------------------------------------------------------------
# Primary resource under test
# ---------------------------------------------------------------------------
resource "azurerm_service_plan" "pass_consumption_plan" {
  name                = "asp-pass-consumption-dev"
  resource_group_name = azurerm_resource_group.pass_consumption_rg.name
  location            = azurerm_resource_group.pass_consumption_rg.location
  os_type             = "Linux"

  sku_name = "Y1" # ✅ PASS: "y1".startswith(("b","s","p")) → False — Guard 2 not triggered

  tags = {
    environment = "dev" # ✅ PASS: ENV_KEY_PATTERN matches "environment"
                        #          NON_PROD_VALUE_PATTERN matches "dev" → True
                        #          Guard 1 passes through to SKU check
  }
}
