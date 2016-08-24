defmodule Exnumerator.Mixfile do
  use Mix.Project

  def project do
    [
      app:             :exnumerator,
      version:         "1.2.1",
      elixir:          "~> 1.3",
      build_embedded:  Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description:     description(),
      package:         package(),
      deps:            deps(Mix.env)
    ]
  end

  def application do
    [
      applications: apps(),
    ]
  end

  defp apps do
    []
  end

  defp deps(:dev) do
    [
      {:ex_doc, ">= 0.0.0"},
    ]
  end

  defp deps(_) do
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
      links:       %{ "GitHub" => "https://github.com/KamilLelonek/exnumerator" },
    ]
  end
end
