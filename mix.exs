defmodule CloudMonitoringExporter.MixProject do
  use Mix.Project

  def project do
    [
      app: :cloud_monitoring_exporter,
      deps: deps(),
      dialyzer: dialyzer(),
      elixir: "~> 1.14",
      preferred_cli_env: [
        test: :test
      ],
      start_permanent: Mix.env() == :prod,
      version: "0.1.0"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {CloudMonitoringExporter.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev, :test], runtime: false},
      {:google_api_monitoring,
       git: "https://github.com/akasprzok/google_api_monitoring_v3.git", branch: "main"},
      {:goth, "~> 1.3"},
      {:plug_cowboy, "~> 2.6.0"},
      # https://github.com/deadtrickster/prometheus.ex/issues/48
      {:prometheus_ex,
       git: "https://github.com/lanodan/prometheus.ex", branch: "fix/elixir-1.14", override: true},
      {:prometheus_plugs, "~> 1.1"},
      {:typed_struct, "~> 0.3"},
      {:yaml_elixir, "~> 2.9"}
    ]
  end

  defp dialyzer do
    [
      plt_core_path: "priv/plts",
      plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
    ]
  end
end
