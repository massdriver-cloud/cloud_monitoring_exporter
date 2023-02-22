defmodule Miser.Client.ListMetricDescriptorsRequest do
  use TypedStruct

  typedstruct do
    field(:project_id, :string)
    field(:user_labels, :map)
    field(:metric_type_prefix, :string)
    field(:interval_seconds, :integer, default: 5 * 60)
  end
end
