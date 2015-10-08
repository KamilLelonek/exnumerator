defmodule Exnumerable.Mixfile do
  use Mix.Project

  def project do
    [
      app:             :exnumerable,
      version:         "0.0.1",
      elixir:          "~> 1.1",
      build_embedded:  Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps:            deps
    ]
  end

  def application do
    [
      applications: apps
    ]
  end

  defp apps do
    []
  end

  defp deps do
    []
  end
end
