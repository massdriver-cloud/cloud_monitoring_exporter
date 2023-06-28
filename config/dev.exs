import Config

config :cloud_monitoring_exporter, CloudMonitoringExporter.Config,
  project_id: "md-sandbox-andreas",
  metric_type_prefixes: ["cloudsql.googleapis.com/database/cpu"],
  user_labels: %{
    "managed-by" => "massdriver"
  }
