defmodule ASPK.MixProject do
  use Mix.Project

  def project do
    [
      app: :aspk,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:ecto_sqlite3, ">= 0.0.0"}
    ]
  end
end
