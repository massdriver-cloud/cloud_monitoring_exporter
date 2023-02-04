defmodule AzureMetricsExporterProxyTest do
  use ExUnit.Case
  doctest AzureMetricsExporterProxy
  use Plug.Test

  import Tesla.Mock

  setup do
    mock(fn
      %{method: :get, url: "https://example.com/metrics"} ->
        %{status: 200, body: "Hello world"}
      end)
    :ok
  end

  test "do stuff" do
    conn = conn(:get, "/metrics") |> AzureMetricsExporterProxy.Router.call([])
    assert conn.status == 200
  end

end
