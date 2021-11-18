defmodule ASPK do
  @moduledoc """
  High-level ASPK API functions.
  """

  @version "0.7.2"

  def version, do: @version

  @doc """
  Create and store a token in the database. Returns the encoded string token.
  """
  @spec create_token() :: binary()
  def create_token do
    changeset = ASPK.Token.creation_changeset()

    case ASPK.Repo.insert(changeset) do
      {:ok, _} -> {:ok, ASPK.Token.encode(changeset)}
      err -> err
    end
  end

  @spec create_token!() :: binary()
  def create_token! do
    changeset = ASPK.Token.creation_changeset()
    ASPK.Repo.insert!(changeset)
    ASPK.Token.encode(changeset)
  end
  
  @doc """
  Revoke a token, deleting it from the database.
  """
  @spec revoke_token(ASPK.Token.t()) :: {:ok, ASPK.Token.t()} | {:error, Ecto.Changeset.t()}
  def revoke_token(token) do
    ASPK.Repo.delete(token)
  end
end
