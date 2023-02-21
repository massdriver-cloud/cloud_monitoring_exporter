defmodule Miser.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    credentials = Application.get_env(:miser, :credentials_json)
      |> Jason.decode!()

    source = {:service_account, credentials}

    children = [
      {Goth, name: Miser.Goth, source: source}
    ]

    opts = [strategy: :one_for_one, name: Miser.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
