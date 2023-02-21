defmodule Miser.ApplicationMetrics do
  @moduledoc """
  """

  use PromEx, otp_app: :miser

  alias PromEx.Plugins

  @impl true
  def plugins do
    [
      Plugins.Application,
      Plugins.Beam
    ]
  end

  @impl true
  def dashboard_assigns do
    [
      datasource_id: "prometheus",
      default_selected_interval: "30s"
    ]
  end

  @impl true
  def dashboards do
    [
      {:prom_ex, "application.json"},
      {:prom_ex, "beam.json"}
    ]
  end
end
