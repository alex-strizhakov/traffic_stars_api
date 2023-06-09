defmodule TrafficStarsApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :traffic_stars_api,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla, "~> 1.5"},
      {:jason, ">= 1.0.0"},
      {:mint, "~> 1.0"},
      {:mox, "~> 1.0", only: :test}
    ]
  end
end
