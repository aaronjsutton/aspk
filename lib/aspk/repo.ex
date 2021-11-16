defmodule ASPK.Repo do
  use Ecto.Repo,
    otp_app: :aspk,
    adapter: Ecto.Adapters.SQLite3
end
