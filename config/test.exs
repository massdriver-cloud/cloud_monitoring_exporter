import Config

config :cloud_monitoring_exporter, CloudMonitoringExporter.Config,
  project_id: "my_project_id",
  metric_type_prefixes: ["cloudsql.googleapis.com/database/cpu"],
  user_labels: %{
    "environment" => "dev"
  }
