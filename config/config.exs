import Config

config :aspk, ASPK.Repo, database: "aspk.sqlite3"

config :aspk, ecto_repos: [ASPK.Repo]

import_config "#{Mix.env()}.exs"

