defmodule Miser.MixProject do
  use Mix.Project

  def project do
    [
      app: :miser,
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
      {:prom_ex, "~> 1.7"},
      {:plug_cowboy, "~> 2.5"}
    ]
  end
end
