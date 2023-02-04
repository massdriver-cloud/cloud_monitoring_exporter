import Config

config :reverse_proxy_plug, :http_client, ReverseProxyPlug.HTTPClient.Adapters.Tesla

config :tesla, adapter: Tesla.Adapter.Hackney

import_config "#{Mix.env()}.exs"
