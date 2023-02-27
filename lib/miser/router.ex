defmodule Miser.Router do
  use Plug.Router
  use Plug.ErrorHandler

  plug(:match)
  plug(:dispatch)

  forward("/metrics", to: Miser)

  match _ do
    send_resp(conn, 404, "Oops!")
  end

  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    send_resp(conn, conn.status, "Something went wrong")
  end
end
