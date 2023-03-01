import Config

if Mix.env() == :prod do
  config :miser, Miser, YamlElixir.read_from_file!("/config/config.yml")
else
  config :miser, Miser, %{
    project_id: "my-project"
  }
end
