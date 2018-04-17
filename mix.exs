defmodule Exnumerator.Mixfile do
  use Mix.Project

  def project do
    [
      app: :exnumerator,
      version: "1.7.2",
      elixir: "~> 1.6",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [
      applications: []
    ]
  end

  defp deps do
    [
      {:ecto, "~> 2.2", optional: true},
      {:ex_doc, "~> 0.18", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    Enumerable type definition in a simple way to be used with any database.
    """
  end

  defp package do
    [
      files: ["lib", "config", "mix.exs", "README.md"],
      maintainers: ["Kamil Lelonek"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/KamilLelonek/exnumerator"}
    ]
  end
end
