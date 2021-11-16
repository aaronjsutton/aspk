defmodule ASPK.Repo.Migrations.AddTokensTable do
  use Ecto.Migration

  def change do
    create table("tokens", primary_key: false) do
      add :id, :binary_id, [:primary_key]
      add :hashed_secret, :string

      timestamps()
    end
  end
end
