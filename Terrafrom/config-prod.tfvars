#project details
project_name         = "edialoutbound"
environment          = "prod"
instance             = "0001"
instance_short       = "01"
Aspdotnet_core_env   = "Prod"


#resource group details
resource_group_name  = "tf-rg"
location             = "westus2"
location_short       = "wus2"
tags = {
    application     = "edialoutbound",
    environment     = "prod",
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
  EnabledRegions    = "TFTN,TFNJ,TFFL,TFTX,TFRI,TFCO,TFNW,TFPI,TFNE,TFMX,TFSW,TFCA,TBCP,TFCF,DRTL"
  EnableDR          = false
}

#vendor_rbac_resource_group = ["8fe1fff3-86c3-4f26-ad8e-1e4e5dbdaa40","ce315900-924d-4aa4-bafa-b90f88521da3","f8aed9bd-6d99-46f9-b062-df9d82a03496","cd575310-abb7-46a6-b26a-30790f715d22","206c1d74-eeab-44b1-ba37-055f4ef71103"]


#event hub details
eventhubnamespace         = "tf-evhns"
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
storage_acc = "tfstprdedialoutwus2"
storage_con = ["edialoutboundservice-singlton","edialoutboundservice-adls-csv-checkpoint","fdr-dataentity-checkpoint","fdr-batchstatus-checkpoint"]


# Grafana details
Manged_grafana     = "tf-grafna"
Subscription_ID    = "b388629f-18c1-4a42-9152-6ba0550f07cf" # tffi-corp-prod
grafana_role_assignments = [
  {
    # Grafana Admins: Pasupathikumar, Nagaraju Bondala, Harikrishna Mundra
    principal_id = ["c3d05cba-3437-4f67-8711-ac975ea151a7"]
    role_name    = "Grafana Admin"
  },
  {
    # grp_azr_vendor_prod_edial_grafana_editor
    principal_id = ["4ee49d5a-75f7-424e-aa2a-579da14246f2"]
    role_name    = "Grafana Editor"
  },
  {
    # grp_azr_vendor_prod_edial_grafana_viewer
    principal_id = ["26789166-cf02-40a7-a9a5-301f30d01cc2", "ce55996c-2ea1-431f-bd52-27db45ba923b", "2d5446da-ecfb-41bc-a343-0527786920f0", "49a6b65b-3aa1-4a43-947e-4724949efbd7"]
    role_name    = "Grafana Viewer"
  }
]

resource_group_role_assignments = [
  {
    principal_id = ["26789166-cf02-40a7-a9a5-301f30d01cc2", "ce55996c-2ea1-431f-bd52-27db45ba923b", "2d5446da-ecfb-41bc-a343-0527786920f0"]
    role_name    = "Reader"
  },
  {
    principal_id = ["4ee49d5a-75f7-424e-aa2a-579da14246f2", "c3d05cba-3437-4f67-8711-ac975ea151a7"] #grp_azr_vendor_appdev_prod_contributor #grp_azr_vendor_devops_prod_contributor
    role_name    = "Contributor"
  }
]


storage_account_role_assignments = [
  {
    principal_id = ["4ee49d5a-75f7-424e-aa2a-579da14246f2", "c3d05cba-3437-4f67-8711-ac975ea151a7", "bca47b34-b075-4947-abdf-eb580e75f9a0"]
    role_name    = "Storage Blob Data Contributor"
  },
  {
    principal_id = ["26789166-cf02-40a7-a9a5-301f30d01cc2", "ce55996c-2ea1-431f-bd52-27db45ba923b", "2d5446da-ecfb-41bc-a343-0527786920f0"]
    role_name    = "Storage Blob Data Reader"
  }
]

storage_account_role_assignments_serviceprincipal = [
  {
    principal_id = ["13fd7f29-b969-4941-bc23-3a422f2bf1f0","18fa703d-cf60-4e7e-a74d-0d5f15eba96e","589485d3-13c1-4a87-8276-9c9286710294","fc708534-f673-47e2-9ba1-241fec05e9e4"]
    role_name    = "Storage Blob Data Contributor"
  }
]

eventhub_role_assigments_service_principal = [
  {
    principal_id = ["13fd7f29-b969-4941-bc23-3a422f2bf1f0","18fa703d-cf60-4e7e-a74d-0d5f15eba96e","589485d3-13c1-4a87-8276-9c9286710294","fc708534-f673-47e2-9ba1-241fec05e9e4"] #, #, # wus2prdedlapp01, # wus2prdedlapp02
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
container_app_environment         = "Prod"
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
