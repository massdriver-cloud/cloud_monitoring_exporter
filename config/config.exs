import Config

config :reverse_proxy_plug, :http_client, ReverseProxyPlug.HTTPClient.Adapters.Tesla

import_config "#{Mix.env()}.exs"
