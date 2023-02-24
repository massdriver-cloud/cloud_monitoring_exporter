defmodule Miser.Collector do
  @moduledoc """
  Usually, collectors aren't used directly.
  Instead, higher level abstractions such as Histogram or Gauge are used.
  But here we're effectively proxying Cloud Monitoring metrics to Prometheus,
  so this is an extremely useful abstraction for us.
  Firstly, collect_mf/2 is called whenever the /metrics endpoint is hit -
  meaning we only need to hit the Cloud Monitoring API when Prometheus asks for metrics.
  Secondly, since we're creating the entire payload from scratch every time,
  we don't have to keep track of which metrics go away from one scrape to another -
  we completely recreate the payload from the relevant metric descriptors on every scrape.
  """
  use Prometheus.Collector

  alias Miser.Client
  alias Miser.Client.{ListMetricDescriptorsRequest, ListTimeSeriesRequest}
  alias Prometheus.Model

  def collect_mf(_registry, callback) do
    config = Application.get_env(:miser, Miser)
    project_id = Keyword.fetch!(config, :project_id)
    user_labels = Keyword.fetch!(config, :user_labels)

    config
    |> Keyword.fetch!(:metric_type_prefixes)
    # should probably parallelize this
    |> Enum.each(fn metric_type_prefix ->
      request = %ListMetricDescriptorsRequest{
        project_id: project_id,
        user_labels: user_labels,
        metric_type_prefix: metric_type_prefix
      }

      with {:ok, response} <- Client.list_metric_descriptors(request) do
        response.metricDescriptors
        |> Enum.map(fn descriptor ->
          name = to_prometheus_name(descriptor.type)

          request = %ListTimeSeriesRequest{
            project_id: project_id,
            user_labels: user_labels,
            metric_type: descriptor.type
          }

          callback.(create_gauge(name, descriptor.description, request))
        end)
      end
    end)

    :ok
  end

  def collect_metrics(_name, request) do
    with {:ok, response} <- Client.list_time_series(request) do
      response.timeSeries
      |> Enum.map(fn time_series ->
        value_type = time_series.valueType
        value = time_series.points |> List.first() |> Map.get(:value) |> get_value(value_type)
        labels = time_series.resource.labels |> Enum.into([])
        Model.gauge_metric(labels, value)
      end)
    end
  end

  defp get_value(%{doubleValue: value}, "DOUBLE") do
    value
  end

  defp get_value(%{int64Value: value}, "INT64") do
    value
  end

  defp create_gauge(name, help, data) do
    Model.create_mf(name, help, :gauge, __MODULE__, data)
  end

  defp to_prometheus_name(name) do
    name
    |> String.replace([".", "/"], "_")
  end
end
