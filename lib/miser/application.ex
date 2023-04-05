defmodule CloudMonitoringExporter.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Prometheus.Registry.register_collector(CloudMonitoringExporter.Collector)

    children = [
      {Plug.Cowboy, scheme: :http, plug: CloudMonitoringExporter.Router, port: 9090},
      {Goth, name: CloudMonitoringExporter.Goth}
    ]

    :ok = CloudMonitoringExporter.Config.configure()

    opts = [strategy: :one_for_one, name: CloudMonitoringExporter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
