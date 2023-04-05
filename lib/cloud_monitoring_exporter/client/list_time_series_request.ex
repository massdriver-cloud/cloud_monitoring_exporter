defmodule CloudMonitoringExporter.Client.ListTimeSeriesRequest do
  @moduledoc false
  use TypedStruct

  typedstruct do
    field(:interval_seconds, :integer, default: 5 * 60)
    field(:metric_type, :string)
    field(:project_id, :string)
    field(:user_labels, :map)
  end
end
