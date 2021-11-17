defmodule ASPK.Token do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, []}

  schema "tokens" do
    field(:secret, :string, virtual: true)
    field(:hashed_secret, :string)

    timestamps()
  end

  @doc """
  Generate a changeset for creating a new `Token`. Since `id` and `secret` are
  generated randomly, this 
  """
  def creation_changeset() do
    %ASPK.Token{}
    |> change(%{
      id: ASPK.Generator.generate_id(),
      secret: ASPK.Generator.generate_secret()
    })
    |> prepare_changes(&hash_secret/1)
  end

  def encode(%Ecto.Changeset{changes: %{secret: secret, id: id}}) do
    Plug.BasicAuth.encode_basic_auth(id, secret)
  end

  defp hash_secret(changeset) do
    secret = get_change(changeset, :secret)

    changeset
    |> put_change(:hashed_secret, Bcrypt.hash_pwd_salt(secret))
    |> delete_change(:secret)
  end

  def valid_secret?(%ASPK.Token{hashed_secret: hashed_secret}, secret)
      when is_binary(hashed_secret) and byte_size(secret) > 0 do
    Bcrypt.verify_pass(secret, hashed_secret)
  end

  def valid_secret?(_, _) do
    Bcrypt.no_user_verify()
    false
  end
end
