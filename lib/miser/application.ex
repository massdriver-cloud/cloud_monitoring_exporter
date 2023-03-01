defmodule Miser.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Prometheus.Registry.register_collector(Miser.Collector)
    Miser.setup()

    children = [
      {Plug.Cowboy, scheme: :http, plug: Miser.Router, port: 9090},
      {Goth, name: Miser.Goth}
    ]

    opts = [strategy: :one_for_one, name: Miser.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
