import Config

config :aspk, ASPK.Repo,
  database: "data/aspk_test.sqlite3",
  pool: Ecto.Adapters.SQL.Sandbox

config :aspk, ASPK.Server, port: 9091

config :logger, level: :info
