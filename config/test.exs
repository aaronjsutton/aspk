use Mix.Config

config :aspk, ASPK.Server, port: 9091

config :aspk, ASPK.Repo,
  database: "aspk_test.sqlite3",
  pool: Ecto.Adapters.SQL.Sandbox
