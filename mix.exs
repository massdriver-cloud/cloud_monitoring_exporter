defmodule Miser.MixProject do
  use Mix.Project

  def project do
    [
      app: :miser,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      preferred_cli_env: [
        test: :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Miser.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:goth, "~> 1.3"},
      {:google_api_monitoring,
       git: "git@github.com:akasprzok/google_api_monitoring_v3.git", branch: "main"},
      {:typed_struct, "~> 0.3"},
      {:plug_cowboy, "~> 2.5"},
      # https://github.com/deadtrickster/prometheus.ex/issues/48
      {:prometheus_ex,
       git: "https://github.com/lanodan/prometheus.ex", branch: "fix/elixir-1.14", override: true},
      {:prometheus_plugs, "~> 1.1"},
      {:credo, "~> 1.6", only: [:dev], runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false}
    ]
  end
end
