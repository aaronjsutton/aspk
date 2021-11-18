defmodule ASPK.MixProject do
  use Mix.Project

  def project do
    [
      app: :aspk,
      version: "0.7.2",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ASPK.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bcrypt_elixir, "~> 2.3.0"},
      {:ecto, "~> 3.7.0"},
      {:ecto_sqlite3, ">= 0.0.0"},
      {:plug, "~> 1.12.0"}
    ]
  end

  defp aliases do
    [
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
