import Config

config :prometheus, CloudMonitoringExporter, path: "/"

# Disable all the default collectors
config :prometheus, :vm_dist_collector_metrics, []
config :prometheus, :vm_memory_collector_metrics, []
config :prometheus, :vm_system_info_collector_metrics, []
config :prometheus, :vm_msacc_collector_metrics, []
config :prometheus, :vm_statistics_collector_metrics, []
config :prometheus, :mnesia_collector_metrics, []

import_config "#{Mix.env()}.exs"
