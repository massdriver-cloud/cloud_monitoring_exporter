import Config

config :miser, Miser,
  project_id: "md-sandbox-andreas",
  metric_type_prefixes: [
    "cloudsql.googleapis.com/database/cpu"
  ],
  user_labels: %{
    "managed-by" => "massdriver",
    "md-project" => "adreasa",
    "md-target" => "dev"
  }
