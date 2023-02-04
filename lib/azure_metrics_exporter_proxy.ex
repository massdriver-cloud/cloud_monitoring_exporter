defmodule AzureMetricsExporterProxy do
  @moduledoc false

  @doc """
  Fetches the subscription ID from the application environment.
  """
  @spec subscription_id :: String.t()
  def subscription_id do
    Application.fetch_env!(:azure_metrics_exporter_proxy, :subscription_id)
  end
end
