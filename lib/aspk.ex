defmodule ASPK do
  @moduledoc """
    High-level ASPK functions.
  """

  @doc """
  Create and store a token in the database. Returns the encoded string token.
  """
  def create_token do
    changeset = ASPK.Token.creation_changeset()

    case ASPK.Repo.insert(changeset) do
      {:ok, _} -> ASPK.Token.encode(changeset)
      err -> err
    end
  end

  def create_token! do
    changeset = ASPK.Token.creation_changeset()
    ASPK.Repo.insert!(changeset)
    ASPK.Token.encode(changeset)
  end

  def revoke_token(token) do
    ASPK.Repo.delete(token)
  end
end
