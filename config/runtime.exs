import Config

if config_env() == :prod do
  config :miser, credentials_json: File.read!("credentials.json")
else
  config :miser, credentials_json: File.read!("credentials_test.json")
end

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
