defmodule ASPK.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias ASPK.Repo

      import Ecto
      import Ecto.Query
      import ASPK.RepoCase

    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(ASPK.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(ASPK.Repo, {:shared, self()})
    end

    :ok
  end
end
