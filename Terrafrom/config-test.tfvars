#project details
project_name         = "edialoutbound"
environment          = "test"
instance             = "0001"
instance_short       = "01"
Aspdotnet_core_env   = "Test"


#resource group details
resource_group_name  = "tf-rg"
location             = "westus2"
location_short       = "wus2"
tags = {
    application     = "edialoutbound",
    environment     = "test",
    deployment_type = "terraform"
}

#app service details
app_service_plan     = "tf-asp"
asp_worker_count     = 3
app_service          = "tf-app"
app_insights         = "tf-appi"
log_analytics        = "tf-log"
app_service_feature_flags = {
  FullLoadRegions   = ""
  EnabledRegions    = "TBCP,TFCA,TFCF,TFCO,TFFL,TFMX,TFNE,TFNJ,TFNW,TFPI,TFRI,TFSW,TFTN,TFTX,DRTL"
  EnableDR          = false
}


#vendor_rbac_resource_group = ["8fe1fff3-86c3-4f26-ad8e-1e4e5dbdaa40","ce315900-924d-4aa4-bafa-b90f88521da3","f8aed9bd-6d99-46f9-b062-df9d82a03496","cd575310-abb7-46a6-b26a-30790f715d22","206c1d74-eeab-44b1-ba37-055f4ef71103"]


#event hub details
eventhubnamespace    = "tf-evhns"
eventhubname_csv          = "tf-evh-adls-csv"
eventhubname_dataentity   = "tf-evh-dataentity"
eventhubroles             = ["Azure Event Hubs Data sender", "Azure Event Hubs Data receiver"]
eventhubcsvconsumergroups = ["edialoutboundservice-worker"]
eventhubdataentityconsumergroups = ["fdr-dataentity-checkpoint"]
eventhub_namespace_capacity      = 10

#redis cache detail
redis_cache_name     = "tf-redis"
redis_cache_location = "westcentralus"
amr_name             =  "tf-amr"

#storage account details
storage_acc = "tfsttstedialoutwus2"
storage_con = ["edialoutboundservice-singlton","edialoutboundservice-adls-csv-checkpoint","fdr-dataentity-checkpoint","fdr-batchstatus-checkpoint"]


# Grafana details
Manged_grafana     = "tf-grafna"
Subscription_ID    = "119946f5-b2d2-4e2a-a290-26a4c6da62e4" #tffi-innovation-test
grafana_role_assignments = [
  {
    # Grafana Admins: Pasupathikumar, Nagaraju Bondala, Harikrishna Mundra
    principal_id = ["e8bc513e-1433-4339-8b47-22c74d6d48fa"]
    role_name    = "Grafana Admin"
  },
  {
    # grp_azr_vendor_test_edialoutbound_amg_editor
    principal_id = ["05e8db35-3578-4429-90d5-b0f97f8b3504"]
    role_name    = "Grafana Editor"
  },
  {
    # grp_azr_vendor_test_edialoutbound_amg_viewer
    principal_id = ["26789166-cf02-40a7-a9a5-301f30d01cc2", "ce55996c-2ea1-431f-bd52-27db45ba923b", "55f13faf-4488-4ac9-93d9-873c151dca0f"]
    role_name    = "Grafana Viewer"
  }
]
resource_group_role_assignments = [
  {
    principal_id = ["51c4c605-652a-4b7e-aad9-37e73f9bbffa", "aa78f334-b7d3-4722-9a05-f411c6e4a14a", "55f13faf-4488-4ac9-93d9-873c151dca0f"]
    role_name    = "Reader"
  },
  {
    principal_id = ["05e8db35-3578-4429-90d5-b0f97f8b3504", "e8bc513e-1433-4339-8b47-22c74d6d48fa"] #grp_azr_vendor_appdev_test_contributor #grp_azr_vendor_devops_test_contributor
    role_name    = "Contributor"
  }
]

storage_account_role_assignments = [
  {
    principal_id = ["05e8db35-3578-4429-90d5-b0f97f8b3504", "e8bc513e-1433-4339-8b47-22c74d6d48fa"]
    role_name    = "Storage Blob Data Contributor"
  },
  {
    principal_id = ["51c4c605-652a-4b7e-aad9-37e73f9bbffa", "aa78f334-b7d3-4722-9a05-f411c6e4a14a"]
    role_name    = "Storage Blob Data Reader"
  }
]

storage_account_role_assignments_serviceprincipal = [
  {
    principal_id = ["7e2f762a-eb11-431c-9362-cc7310d811dc","f86462cd-a3b0-4f7c-893a-2f9559b975a0","cbac8e42-fac8-4776-9ede-9e1fbabb40de","d24950b9-1e79-4434-aef8-e15995b9f692"]
    role_name    = "Storage Blob Data Contributor"
  }
]

eventhub_role_assigments_service_principal = [
  {
    principal_id = ["7e2f762a-eb11-431c-9362-cc7310d811dc","f86462cd-a3b0-4f7c-893a-2f9559b975a0","cbac8e42-fac8-4776-9ede-9e1fbabb40de","d24950b9-1e79-4434-aef8-e15995b9f692"] #, #, #wus2tstedlapp01, #wus2tstedlapp02]
    role_name    = "Azure Event Hubs Data Receiver"
  }
]

#Key Vault details
key_vault          = "tfkv"
project_name_short = "eob"
keyvault_access_policy_vendor_list = ["6a44d1cf-8cd7-478c-b339-21f7f6b62616","dce0f851-a718-47fa-a856-a13d1af4e542","95d4e3ed-75e9-44bf-b345-bf1db3846890"] #Pasupathikumar, #Nagaraju Bondala, #Harikrishna Mundra

# FDR Batch Status Event Hub Details
eventhub_fdrbatchstatus  = "tf-evh-batchstatus"
eventhubfdrconsumergroups = ["fdr-batchstatus-consumer"]

container_registry_name           = "tfcr"
container_app_environment_name    = "tf-cae"
container_app_name                = "tf-ca"
container_app_environment         = "Test"
monitor_action_group_name         = "tf-ag"
monitor_action_group_short_name   = "tfag"
monitor_alert_name                = "tf-apr"
monitor_alert_email_receivers        = [
    {
        receiver_name    = "Pasupathikumar"
        receiver_mail_id = "ven_pkumar@taylorfarms.com"
    },
    {
        receiver_name    = "Mohammed Basharath Ahmed"
        receiver_mail_id = "ven_mbahmed@taylorfarms.com"
    },
    {
        receiver_name    = "Chandra Chalicheemala(C2S)"
        receiver_mail_id = "Ven_CChalicheemala@taylorfarms.com"
    },
    {
        receiver_name    = "Kalyan Chakravarthi Bondala(C2S)"
        receiver_mail_id = "ven_KCBondala@taylorfarms.com"
    }
]

feature_flag = {
  EnableDeltaEvents = "false"
}
