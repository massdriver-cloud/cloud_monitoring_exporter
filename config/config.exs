import Config

config :miser, credentials_json: File.read!("credentials.json")

config :miser, Miser.Metrics,
  disabled: false,
  manual_metrics_start_delay: :no_delay,
  drop_metrics_groups: [],
  grafana: :disabled,
  metrics_server: [
    enabled: true,
    port: 9090,
    path: "/metrics"
  ]
