defmodule CloudMonitoringExporter.Client.ListMetricDescriptorsRequest do
  @moduledoc false
  use TypedStruct

  typedstruct do
    field(:metric_type_prefix, :string)
    field(:project_id, :string)
    field(:user_labels, :map)
  end
end
