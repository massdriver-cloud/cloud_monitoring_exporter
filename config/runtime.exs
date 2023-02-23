import Config

config :miser, Miser.ApplicationMetrics,
  disabled: not Env.get("ENABLE_APPLICATION_METRICS", :boolean, false),
  manual_metrics_start_delay: :no_delay,
  drop_metrics_groups: [],
  grafana: :disabled,
  metrics_server: [
    enabled: true,
    port: 9091,
    path: "/metrics"
  ]

config :miser, Miser.Metrics.Poller,
  project_id: "md-sandbox-andreas",
  metrics_type_prefixes: [
    "cloudsql.googleapis.com/database/cpu/utilization"
  ],
  user_labels: %{
    "managed-by" => "massdriver",
    "md-project" => "adreasa",
    "md-target" => "dev"
  }
