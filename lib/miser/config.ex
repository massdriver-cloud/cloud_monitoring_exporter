defmodule Miser.Config do
  @moduledoc """
  Managed Miser config.any()

  This useful wrapper lets us evaluate config files for when this thing is configured on k8s.
  """

  def configure do
    Application.get_env(:miser, __MODULE__)
    |> Keyword.get(:file)
    |> case do
      nil -> :ok
      file -> evaluate_config_file(file)
    end
  end

  def project_id do
    Application.fetch_env!(:miser, __MODULE__)
    |> Keyword.fetch!(:project_id)
  end

  def user_labels do
    Application.fetch_env!(:miser, __MODULE__)
    |> Keyword.get(:user_labels, [])
  end

  def metric_type_prefixes do
    Application.fetch_env!(:miser, __MODULE__)
    |> Keyword.fetch!(:metric_type_prefixes)
  end

  def evaluate_config_file(path) do
    config_map = YamlElixir.read_from_file!(path)

    config = [
      project_id: Map.fetch!(config_map, "project_id"),
      user_labels: Map.get(config_map, "user_labels", %{}),
      metric_type_prefixes: Map.fetch!(config_map, "metric_type_prefixes")
    ]

    Application.put_env(:miser, __MODULE__, config)
  end
end
