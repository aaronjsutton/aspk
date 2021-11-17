import Config

config :aspk, ASPK.Repo, database: "data/aspk.sqlite3"

config :aspk, ASPK.Server, port: 9589

config :aspk, ecto_repos: [ASPK.Repo]

import_config "#{Mix.env()}.exs"

