resource "azurerm_storage_account" "storageaccount" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier             = var.account_tier
  access_tier              = var.access_tier
  account_kind             = var.account_kind
  account_replication_type = var.account_replication_type

  enable_https_traffic_only = var.enable_https_traffic_only
  min_tls_version           = var.min_tls_version
  allow_blob_public_access  = var.allow_blob_public_access

  is_hns_enabled           = var.is_hns_enabled
  nfsv3_enabled            = var.nfsv3_enabled
  large_file_share_enabled = var.large_file_share_enabled

  dynamic "routing" {
    for_each = var.routing == false ? [] : [1]
    content {
      publish_internet_endpoints  = var.routing_publish_internet_endpoints
      publish_microsoft_endpoints = var.routing_publish_microsoft_endpoints
      choice                      = var.routing_choice
    }
  }

  dynamic "static_website" {
    for_each = var.static_website_index_document != "" && var.static_website_error_404_document != "" ? [1] : []
    content {
      index_document     = var.static_website_index_document
      error_404_document = var.static_website_error_404_document
    }
  }

  dynamic "custom_domain" {
    for_each = var.custom_domain_name == "" ? [] : [1]
    content {
      name          = var.custom_domain_name
      use_subdomain = var.custom_domain_use_subdomain
    }
  }

  dynamic "identity" {
    for_each = var.identity
    content {
      type         = identity.value["type"]
      identity_ids = try(identity.value["identity_ids"], null)
    }
  }

  dynamic "blob_properties" {
    for_each = var.blob_properties == false ? [] : [1]
    content {
      dynamic "cors_rule" {
        for_each = var.blob_properties_cors_rule
        content {
          allowed_headers    = cors_rule.value["allowed_headers"]
          allowed_methods    = cors_rule.value["allowed_methods"]
          allowed_origins    = cors_rule.value["allowed_origins"]
          exposed_headers    = cors_rule.value["exposed_headers"]
          max_age_in_seconds = cors_rule.value["max_age_in_seconds"]
        }
      }
      versioning_enabled       = var.blob_properties_versioning_enabled
      default_service_version  = var.blob_properties_default_service_version
      last_access_time_enabled = var.blob_properties_last_access_time_enabled
      delete_retention_policy { days = var.blob_properties_delete_retention_policy_days }
      container_delete_retention_policy { days = var.blob_properties_container_delete_retention_policy_days }
    }
  }

  dynamic "queue_properties" {
    for_each = var.queue_properties == false ? [] : [1]
    content {
      dynamic "cors_rule" {
        for_each = var.queue_properties_cors_rule
        content {
          allowed_headers    = cors_rule.value["allowed_headers"]
          allowed_methods    = cors_rule.value["allowed_methods"]
          allowed_origins    = cors_rule.value["allowed_origins"]
          exposed_headers    = cors_rule.value["exposed_headers"]
          max_age_in_seconds = cors_rule.value["max_age_in_seconds"]
        }
      }

      dynamic "logging" {
        for_each = var.queue_properties_logging == null ? [] : [1]
        content {
          delete                = var.queue_properties_logging["delete"]
          read                  = var.queue_properties_logging["read"]
          version               = var.queue_properties_logging["version"]
          write                 = var.queue_properties_logging["write"]
          retention_policy_days = try(var.queue_properties_logging["retention_policy_days"], null)
        }
      }

      dynamic "minute_metrics" {
        for_each = var.queue_properties_minute_metrics == null ? [] : [1]
        content {
          enabled               = var.queue_properties_minute_metrics["enabled"]
          version               = var.queue_properties_minute_metrics["version"]
          include_apis          = try(var.queue_properties_minute_metrics["include_apis"], null)
          retention_policy_days = try(var.queue_properties_minute_metrics["retention_policy_days"], null)
        }
      }

      dynamic "hour_metrics" {
        for_each = var.queue_properties_hour_metrics == null ? [] : [1]
        content {
          enabled               = var.queue_properties_hour_metrics["enabled"]
          version               = var.queue_properties_hour_metrics["version"]
          include_apis          = var.queue_properties_hour_metrics["include_apis"]
          retention_policy_days = var.queue_properties_hour_metrics["retention_policy_days"]
        }
      }
    }
  }

  dynamic "share_properties" {
    for_each = var.share_properties == false ? [] : [1]
    content {
      dynamic "cors_rule" {
        for_each = var.share_properties_cors_rule
        content {
          allowed_headers    = cors_rule.value["allowed_headers"]
          allowed_methods    = cors_rule.value["allowed_methods"]
          allowed_origins    = cors_rule.value["allowed_origins"]
          exposed_headers    = cors_rule.value["exposed_headers"]
          max_age_in_seconds = cors_rule.value["max_age_in_seconds"]
        }
      }
      retention_policy {
        days = var.share_properties_retention_policy_days
      }
      dynamic "smb" {
        for_each = var.share_properties_smb == null ? [] : [1]
        content {
          versions                        = var.share_properties_smb["versions"]
          authentication_types            = var.share_properties_smb["authentication_types"]
          kerberos_ticket_encryption_type = var.share_properties_smb["kerberos_ticket_encryption_type"]
          channel_encryption_type         = var.share_properties_smb["channel_encryption_type"]
        }
      }
    }
  }

  dynamic "azure_files_authentication" {
    for_each = var.azure_files_authentication_directory_type == null ? [] : [1]
    content {
      directory_type = var.azure_files_authentication_directory_type["directory_type"]
      dynamic "active_directory" {
        for_each = var.azure_files_authentication_directory_type["directory_type"] == "AD" ? [1] : []
        content {
          storage_sid         = var.azure_files_authentication_directory_type["storage_sid"]
          domain_name         = var.azure_files_authentication_directory_type["domain_name"]
          domain_sid          = var.azure_files_authentication_directory_type["domain_sid"]
          domain_guid         = var.azure_files_authentication_directory_type["domain_guid"]
          forest_name         = var.azure_files_authentication_directory_type["forest_name"]
          netbios_domain_name = var.azure_files_authentication_directory_type["netbios_domain_name"]
        }
      }
    }
  }

  tags = var.tags
}

resource "azurerm_storage_account_network_rules" "storageaccountrules" {
  resource_group_name  = azurerm_storage_account.storageaccount.resource_group_name
  storage_account_name = azurerm_storage_account.storageaccount.name

  default_action             = var.firewall_default_action
  ip_rules                   = var.allow_ips
  virtual_network_subnet_ids = var.allow_subnets
  bypass                     = var.storage_account_network_rules_bypass

  dynamic "private_link_access" {
    for_each = var.private_link_access
    content {
      endpoint_resource_id = private_link_access.value["endpoint_resource_id"]
      endpoint_tenant_id   = try(private_link_access.value["endpoint_tenant_id"], null)
    }
  }
}

resource "azurerm_private_endpoint" "storage_account_endpoint" {
  for_each            = { for s in var.private_endpoint_list : format("%s", s.private_endpoint_name) => s }
  name                = each.value.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = try(each.value.subnet_id, var.subnet_id)

  private_service_connection {
    name                           = try(each.value.private_service_connection_name, each.value.private_endpoint_name)
    private_connection_resource_id = azurerm_storage_account.storageaccount.id
    is_manual_connection           = try(each.value.is_manual_connection, false)
    subresource_names              = each.value.subresource_names
    request_message                = try(each.value.request_message, null)
  }

  dynamic "private_dns_zone_group" {
    for_each = try(each.value.private_dns_zone_group_name, var.private_dns_zone_group_name) == null ? [] : [1]

    content {
      name                 = try(each.value.private_dns_zone_group_name, var.private_dns_zone_group_name)
      private_dns_zone_ids = try(each.value.private_dns_zone_ids, var.private_dns_zone_ids)
    }
  }

  depends_on = [azurerm_storage_account.storageaccount, azurerm_storage_account_network_rules.storageaccountrules]
  tags       = var.tags
}

