data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.sku_name

  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization
  purge_protection_enabled        = var.purge_protection_enabled
  soft_delete_retention_days      = var.soft_delete_retention_days

  access_policy {
    certificate_permissions = var.current_user_certificate_permissions
    key_permissions         = var.current_user_key_permissions
    object_id               = data.azurerm_client_config.current.object_id
    secret_permissions      = var.current_user_secret_permissions
    storage_permissions     = var.current_user_storage_permissions
    tenant_id               = data.azurerm_client_config.current.tenant_id
  }

  network_acls {
    default_action             = var.network_acls_default_action
    bypass                     = var.network_acls_bypass
    virtual_network_subnet_ids = var.allow_subnets
    ip_rules                   = var.allow_ips
  }

  dynamic "contact" {
    for_each = var.contact
    content {
      email = contact.value["email"]
      name  = try(contact.value["name"], null)
      phone = try(contact.value["phone"], null)
    }
  }

  lifecycle {
    ignore_changes = [access_policy]
  }

  tags = var.tags
}


resource "azurerm_key_vault_access_policy" "key_vault_access_policy" {
  for_each       = { for s in var.key_vault_access_policy_list : format("%s", s.object_id) => s }
  key_vault_id   = azurerm_key_vault.keyvault.id
  tenant_id      = data.azurerm_client_config.current.tenant_id
  object_id      = each.value.object_id
  application_id = try(each.value.application_id, null)

  key_permissions         = try(each.value.key_permissions, null)
  secret_permissions      = try(each.value.secret_permissions, null)
  storage_permissions     = try(each.value.storage_permissions, null)
  certificate_permissions = try(each.value.certificate_permissions, null)
}


resource "azurerm_monitor_diagnostic_setting" "keyvault_diagnostics" {
  count              = var.diagnostic_settings_enabled == true ? 1 : 0
  name               = azurerm_key_vault.keyvault.name
  target_resource_id = azurerm_key_vault.keyvault.id

  eventhub_name                  = var.eventhub_name
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id
  storage_account_id             = var.storage_account_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = var.log_analytics_destination_type

  log {
    category = var.log_category
    enabled  = var.log_enabled

    retention_policy {
      enabled = var.log_retention_policy_enabled
      days    = var.log_retention_days
    }
  }
  metric {
    category = var.metric_category

    retention_policy {
      enabled = var.metric_retention_policy_enabled
      days    = var.metric_retention_days

    }
  }

  depends_on = [azurerm_key_vault.keyvault]
}
