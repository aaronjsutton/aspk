defmodule ASPK.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ASPK.Repo,
      {ASPK.PlugAdapter, plug: ASPK.Authentication, port: 9000}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ASPK.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
