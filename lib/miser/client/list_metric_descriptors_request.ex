defmodule Miser.Client.ListMetricDescriptorsRequest do
  @moduledoc false
  use TypedStruct

  typedstruct do
    field(:project_id, :string)
    field(:user_labels, :map)
    field(:metric_type_prefix, :string)
  end
end
