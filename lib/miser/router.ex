defmodule Miser.Router do
  use Plug.Router
  use Plug.ErrorHandler

  plug(:match)
  plug(:dispatch)

  forward("/metrics", to: Miser)

  get(_) do
    send_resp(conn, 404, "You don't seem to be hitting /metrics like you should.")
  end
end
