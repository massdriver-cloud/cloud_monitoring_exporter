defmodule Miser.Collector do
  use Prometheus.Collector

  alias Miser.Client.{ListMetricDescriptorsRequest, ListTimeSeriesRequest}

  def collect_mf(_registry, callback) do
    config = Application.get_env(:miser, Miser)
    project_id = Keyword.fetch!(config, :project_id)
    user_labels = Keyword.fetch!(config, :user_labels)

    request = %ListMetricDescriptorsRequest{
      project_id: project_id,
      user_labels: user_labels,
      metric_type_prefix: "cloudsql.googleapis.com/database/cpu"
    }

    with {:ok, response} <- Miser.Client.list_metric_descriptors(request) do
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

    :ok
  end

  def collect_metrics(_name, request) do
    with {:ok, response} = Miser.Client.list_time_series(request) do
      point =
        response.timeSeries
        |> List.first()
        |> Map.get(:points)
        |> List.first()
        |> Map.get(:value)
        |> Map.get(:doubleValue)

      Prometheus.Model.gauge_metric(point)
    end
  end

  defp create_gauge(name, help, data) do
    Prometheus.Model.create_mf(name, help, :gauge, __MODULE__, data)
  end

  defp to_prometheus_name(name) do
    name
    |> String.replace([".", "/"], "_")
  end
end
