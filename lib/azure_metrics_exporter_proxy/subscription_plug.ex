defmodule AzureMetricsExporterProxy.SubscriptionPlug do
  @moduledoc """
  This plug naively appends the supplied subscription_id to the query string.

  opts:
    * subscription_id_mfa: {module, function, args} - a function that returns a string which will be used as the subscription ID query param.
  """

  @type subscription_id :: String.t()

  @spec init(Keyword.t()) :: subscription_id()
  def init(opts) do
    opts
    |> Keyword.fetch!(:subscription_id)
    |> case do
      {module, function, args} -> :erlang.apply(module, function, args)
      subscription_id when is_binary(subscription_id) -> subscription_id
    end
  end

  @spec call(Conn.t(), subscription_id()) :: Conn.t()
  def call(conn, subscription_id) do
    subscription_query =
      Plug.Conn.Query.encode(%{subscription_id: subscription_id})

    query_string = ~s(#{conn.query_string}&#{subscription_query})
    %{conn | query_string: query_string}
  end
end
