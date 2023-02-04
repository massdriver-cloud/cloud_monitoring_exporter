defmodule AzureMetricsExporterProxy.Router do
  use Plug.Router

    plug :match
    plug :dispatch

    get("/metrics") do
      send_resp(conn, 200, "Hello world")
    end
end
