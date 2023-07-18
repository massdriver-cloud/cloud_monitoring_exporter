import Config

config :cloud_monitoring_exporter, CloudMonitoringExporter.Config,
  project_id: "md-sandbox-andreas",
  metric_type_prefixes: [
    "alloydb.googleapis.com/database",
    "apigateway.googleapis.com/proxy",
    "appengine.googleapis.com/flex/autoscaler",
    "appengine.googleapis.com/flex/cpu",
    "appengine.googleapis.com/flex/disk",
    "cloudsql.googleapis.com/database/cpu",
    "cloudsql.googleapis.com/database/disk",
    "cloudsql.googleapis.com/database/memory",
    "compute.googleapis.com/instance/cpu",
    "compute.googleapis.com/instance/disk",
    "compute.googleapis.com/instance/memory",
    "dns.googleapis.com/query",
    "kubernetes.io/container/cpu",
    "kubernetes.io/container/memory",
    "kubernetes.io/node/cpu",
    "kubernetes.io/node/memory",
    "kubernetes.io/node/network",
    "kubernetes.io/pod/network",
    "redis.googleapis.com/clients"
  ],
  user_labels: %{
    "managed-by" => "massdriver"
  }
