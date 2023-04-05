defmodule CloudMonitoringExporter.Client do
  @moduledoc "Client for interacting with the Monitoring API."

  alias GoogleApi.Monitoring.V3.{Api, Connection}
  alias CloudMonitoringExporter.Client.{ListMetricDescriptorsRequest, ListTimeSeriesRequest}

  @aggregation_per_series_aligner "ALIGN_MEAN"
  @aggregation_cross_series_reducer "REDUCE_NONE"
  @aggregation_alignment_period "60s"

  def conn do
    token_fetcher = fn _scopes ->
      {:ok, token} = Goth.fetch(CloudMonitoringExporter.Goth)
      token.token
    end

    Connection.new(token_fetcher)
  end

  def list_time_series(%ListTimeSeriesRequest{} = request) do
    end_time = DateTime.utc_now()
    start_time = end_time |> DateTime.add(request.interval_seconds * -1, :second)

    user_labels =
      request.user_labels
      |> Enum.map(fn {key, value} ->
        ~s|metadata.user_labels."#{key}"="#{value}"|
      end)

    filters =
      [
        ~s|metric.type="#{request.metric_type}"|
      ] ++ user_labels

    opts = [
      {:filter, filters |> Enum.join(" ")},
      {:"aggregation.alignmentPeriod", @aggregation_alignment_period},
      {:"aggregation.perSeriesAligner", @aggregation_per_series_aligner},
      {:"aggregation.crossSeriesReducer", @aggregation_cross_series_reducer},
      {:"interval.endTime", end_time |> DateTime.to_iso8601()},
      {:"interval.startTime", start_time |> DateTime.to_iso8601()}
    ]

    conn()
    |> Api.Projects.monitoring_projects_time_series_list(request.project_id, opts)
    |> parse_response()
  end

  def list_metric_descriptors(%ListMetricDescriptorsRequest{} = request) do
    user_labels =
      request.user_labels
      |> Enum.map(fn {key, value} ->
        ~s|metadata.user_labels."#{key}"="#{value}"|
      end)

    filters =
      [
        ~s|metric.type=starts_with("#{request.metric_type_prefix}")|
      ] ++ user_labels

    opts = [
      {:filter, filters |> Enum.join(" ")}
    ]

    conn()
    |> Api.Projects.monitoring_projects_metric_descriptors_list(request.project_id, opts)
    |> parse_response()
  end

  defp parse_response({:ok, %Tesla.Env{status: status, body: body}}) do
    {:error, "Unexpected status #{status} with body: #{inspect(body)}"}
  end

  defp parse_response({:error, error}), do: {:error, error}

  defp parse_response({:ok, response}), do: {:ok, response}
end
