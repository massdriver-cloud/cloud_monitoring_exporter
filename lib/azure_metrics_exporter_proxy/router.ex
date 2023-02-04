defmodule AzureMetricsExporterProxy.Router do
  use Plug.Router

  alias AzureMetricsExporterProxy.SubscriptionPlug

  plug(:match)
  plug(:dispatch)
  plug(SubscriptionPlug, subscription_id_mfa: {AzureMetricsExporterProxy, :subscription_id, []})

  forward("/",
    to: ReverseProxyPlug,
    upstream: "http://example.com",
    client_options: [tesla_client: Tesla.client([])],
    response_mode: :buffer
  )
end
