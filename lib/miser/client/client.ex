defmodule Miser.Client do
  @moduledoc "Client for interacting with the Monitoring API."

  alias GoogleApi.Monitoring.V3.{Api, Connection, Model}
  alias Miser.Client.Request

  @aggregation_perSeriesAligner "ALIGN_MEAN"
  @aggregation_crossSeriesReducer "REDUCE_NONE"
  @aggregation_alignmentPeriod "60s"

  @spec time_series(Request.t()) :: {:ok, Model.ListTimeSeriesResponse.t()} | {:error, String.t()}
  def time_series(request) do
    end_time = DateTime.utc_now()
    start_time = end_time |> DateTime.add(request.interval_seconds * -1, :second)

    {:ok, token} = Goth.fetch(Miser.Goth)

    conn = Connection.new(token.token)

    user_labels =
      request.user_labels
      |> Enum.map(fn {key, value} ->
        ~s|metadata.user_labels."#{key}"="#{value}"|
      end)

    filters = [
      ~s|metric.type="#{request.metric_type}"|,
    ] ++ user_labels

    opts = [
      {:filter, filters |> Enum.join(" ")},
      {:"aggregation.alignmentPeriod", @aggregation_alignmentPeriod},
      {:"aggregation.perSeriesAligner", @aggregation_perSeriesAligner},
      {:"aggregation.crossSeriesReducer", @aggregation_crossSeriesReducer},
      {:"interval.endTime", end_time |> DateTime.to_iso8601()},
      {:"interval.startTime", start_time |> DateTime.to_iso8601()}
    ]

    Api.Projects.monitoring_projects_time_series_list(conn, request.project_id, opts)
    |> parse_response()
  end

  defp parse_response({:ok, %Model.ListTimeSeriesResponse{} = response}), do: {:ok, response}

  defp parse_response({:ok, %Tesla.Env{status: status, body: body}}) do
    {:error, "Unexpected status #{status} with body: #{inspect(body)}"}
  end

  defp parse_response({:error, error}), do: {:error, error}
end
