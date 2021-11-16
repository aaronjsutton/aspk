defmodule ASPK.Token do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, []}

  schema "tokens" do
    field(:secret, :string, virtual: true)
    field(:hashed_secret, :string)

    timestamps()
  end

  def creation_changeset() do
    %__MODULE__{}
    |> change(%{
      id: ASPK.Generator.generate_id(),
      secret: ASPK.Generator.generate_secret()
    })
    |> prepare_changes(&hash_secret/1)
  end

  defp hash_secret(changeset) do
    secret = get_change(changeset, :secret)

    changeset
    |> put_change(:hashed_secret, Bcrypt.hash_pwd_salt(secret))
    |> delete_change(:secret)
  end


end
