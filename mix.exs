defmodule Exnumerator.Mixfile do
  use Mix.Project

  def project do
    [
      app:             :exnumerator,
      version:         "1.1.0",
      elixir:          "~> 1.2",
      build_embedded:  Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description:     description(),
      package:         package(),
      deps:            deps()
    ]
  end

  def application do
    [
      applications: apps()
    ]
  end

  defp apps do
    []
  end

  defp deps do
    []
  end

  defp description do
    """
    Enumerable type definition in a simple way to be used with any database.
    """
  end

  defp package do
    [
      files:       ["lib", "config", "mix.exs", "README.md"],
      maintainers: ["Kamil Lelonek"],
      licenses:    ["MIT"],
      links:       %{ "GitHub" => "https://github.com/KamilLelonek/exnumerator" }
    ]
  end
end
