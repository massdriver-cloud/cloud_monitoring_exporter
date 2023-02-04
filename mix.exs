defmodule AzureMetricsExporterProxy.MixProject do
  use Mix.Project

  def project do
    [
      app: :azure_metrics_exporter_proxy,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {AzureMetricsExporterProxy.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.6"},
      {:reverse_proxy_plug, "~> 2.1"},
      {:tesla, "~> 1.5"},
      {:hackney, "~> 1.18"}
    ]
  end
end
