port =
  System.get_env("PORT") ||
    raise """
    environment variable port is missing.
    For example: 9589
    """

database =
  System.get_env("DATABASE") ||
    raise """
    environment variable DATABASE is missing.
    For example: /var/lib/aspk/data
    """

config :aspk, ASPK.Repo, database: database
config :aspk, ASPK.Server, port: port
