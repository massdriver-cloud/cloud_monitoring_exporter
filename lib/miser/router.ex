defmodule Miser.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  forward("/", to: Miser.Exporter)
end
