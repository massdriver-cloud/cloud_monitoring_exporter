defmodule Miser.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Goth, name: Miser.Goth, prefetch: :sync}
    ]

    opts = [strategy: :one_for_one, name: Miser.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
