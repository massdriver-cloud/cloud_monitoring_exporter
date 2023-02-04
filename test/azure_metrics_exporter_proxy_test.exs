defmodule AzureMetricsExporterProxyTest do
  use ExUnit.Case
  doctest AzureMetricsExporterProxy
  use Plug.Test

  import Tesla.Mock

  @path "/metrics"
  @params %{
    "name" => "microsoft_cache_redis",
    "template" => "{name}_{metric}_{aggregation}_{unit}",
    "resourceType" => "Microsoft.Cache/Redis",
    "filter" => "where tags['managed-by']=='massdriver'",
    "metric" => ["cacheLatency, cacheRead"],
    "interval" => "PT5M",
    "timespan" => "PT5M",
    "aggregation" => ["Average, Total"]
  }

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

  test "Attaches subscription ID to query string" do
    subscription_id = "1234"
    conn = conn(:get, @path, @params) |> AzureMetricsExporterProxy.Router.call([])
    assert conn.status == 200

    assert conn.query_string |> Plug.Conn.Query.decode() ==
             Map.put(@params, "subscription_id", subscription_id)
  end
end
