defmodule CloudMonitoringExporter.Config do
  @moduledoc false

  def configure do
    config()
    |> Keyword.get(:file)
    |> case do
      nil -> :ok
      file -> evaluate_config_file(file)
    end
  end

  def project_id, do: Keyword.fetch!(config(), :project_id)

  def user_labels, do: Keyword.get(config(), :user_labels, [])

  def metric_type_prefixes, do: Keyword.fetch!(config(), :metric_type_prefixes)

  defp config, do: Application.fetch_env!(:cloud_monitoring_exporter, __MODULE__)

  def evaluate_config_file(path) do
    config_map = YamlElixir.read_from_file!(path)

    config = [
      project_id: Map.fetch!(config_map, "project_id"),
      user_labels: Map.get(config_map, "user_labels", %{}),
      metric_type_prefixes: Map.fetch!(config_map, "metric_type_prefixes")
    ]

    Application.put_env(:cloud_monitoring_exporter, __MODULE__, config)
  end
end
