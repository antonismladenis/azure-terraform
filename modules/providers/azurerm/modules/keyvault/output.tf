output "id" {
  value       = azurerm_key_vault.keyvault.id
  description = "The ID of the Key Vault."
}

output "name" {
  value       = azurerm_key_vault.keyvault.name
  description = "The Name of the Key Vault."

}

output "vault_uri" {
  value       = azurerm_key_vault.keyvault.vault_uri
  description = "The URI of the Key Vault, used for performing operations on keys and secrets."
}

output "diagnostic_settings_id" {
  value       = azurerm_monitor_diagnostic_setting.keyvault_diagnostics[0].id
  description = "The ID of the Diagnostic Setting."
}

