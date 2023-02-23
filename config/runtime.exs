import Config

config :miser, Miser,
  project_id: "md-sandbox-andreas",
  metrics_type_prefixes: [
    "cloudsql.googleapis.com/database/cpu/utilization"
  ],
  user_labels: %{
    "managed-by" => "massdriver",
    "md-project" => "adreasa",
    "md-target" => "dev"
  }
