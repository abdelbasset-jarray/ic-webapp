module "monitoring" {
  source = "github.com/abdelbasset-jarray/icdc-infrastructure-ressources/tree/main/terraform-ressources-aws/monitoring-prometheus-grafana"

  prometheus_hostname   = "prometheus.jarray.mpwin.mooo.com"
  alertmanager_hostname = "alertmanager.jarray.mpwin.mooo.com"
  grafana_hostname      = "grafana.jarray.mpwin.mooo.com"
  config_bucket_name    = "jarray-mpwin-monitoring-config"
}