defmodule Miser.Client.ListTimeSeriesRequest do
  @moduledoc false
  use TypedStruct

  typedstruct do
    field(:project_id, :string)
    field(:user_labels, :map)
    field(:metric_type, :string)
    field(:interval_seconds, :integer, default: 5 * 60)
  end
end
