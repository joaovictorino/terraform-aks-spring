output "host" {
  value = azurerm_kubernetes_cluster.default.kube_config.0.host
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.default.kube_config_raw
}

output "cluster_username" {
  value = azurerm_kubernetes_cluster.default.kube_config.0.username
}

output "cluster_password" {
  value = azurerm_kubernetes_cluster.default.kube_config.0.password
}