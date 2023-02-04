defmodule AzureMetricsExporterProxyTest do
  use ExUnit.Case
  doctest AzureMetricsExporterProxy

  test "greets the world" do
    assert AzureMetricsExporterProxy.hello() == :world
  end
end
