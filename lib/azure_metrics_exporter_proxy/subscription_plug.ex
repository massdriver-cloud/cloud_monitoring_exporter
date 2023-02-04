defmodule AzureMetricsExporterProxy.SubscriptionPlug do
  @moduledoc """
  This plug naively appends the supplied subscription_id to the query string.

  opts:
    * subscription_id_mfa: {module, function, args} - a function that returns a string which will be used as the subscription ID query param.
  """

  @type subscription_id :: String.t()

  @spec init(Keyword.t()) :: subscription_id()
  def init(opts) do
    {module, function, args} =
      opts
      |> Keyword.fetch!(:subscription_id_mfa)

    :erlang.apply(module, function, args)
  end

  @spec call(Conn.t(), subscription_id()) :: Conn.t()
  def call(conn, subscription_id) do
    query_string = conn.query_string <> "&subscription_id=#{subscription_id}"
    %{conn | query_string: query_string}
  end
end
