defmodule AzureMetricsExporterProxy.SubscriptionPlugTest do
  use ExUnit.Case
  doctest AzureMetricsExporterProxy.SubscriptionPlug
  use Plug.Test

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

  test "Attaches subscription ID to query string" do
    subscription_id = UUID.uuid4()
    opts = AzureMetricsExporterProxy.SubscriptionPlug.init(subscription_id: subscription_id)
    conn = conn(:get, @path, @params) |> AzureMetricsExporterProxy.SubscriptionPlug.call(opts)

    assert conn.query_string |> Plug.Conn.Query.decode() ==
             Map.put(@params, "subscription_id", subscription_id)
  end
end
