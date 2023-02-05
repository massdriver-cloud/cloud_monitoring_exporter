defmodule AzureMetricsExporterProxy.RouterTest do
  use ExUnit.Case
  doctest AzureMetricsExporterProxy.Router
  use Plug.Test

  import Tesla.Mock

  @path "/metrics"

  setup do
    mock(fn
      %{method: :get, url: "http://example.com:80#{@path}" <> _rest} ->
        %Tesla.Env{status: 200, body: "i_am_many_prometheus_metrics{label=\"value\"}"}
    end)

    :ok
  end

  test "forwards to the proxy url" do
    conn = conn(:get, @path) |> AzureMetricsExporterProxy.Router.call([])
    assert conn.status == 200
  end
end
