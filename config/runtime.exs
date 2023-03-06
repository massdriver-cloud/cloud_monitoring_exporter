import Config

config :miser, Miser, YamlElixir.read_from_file!("/config/config.yml")
