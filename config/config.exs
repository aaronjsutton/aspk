import Config

config :aspk, ecto_repos: [ASPK.Repo]

import_config "#{Mix.env()}.exs"

