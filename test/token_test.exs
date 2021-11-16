defmodule ASPK.TokenTest do

  use ExUnit.Case

  test "creation_changeset/0 creates a changeset with correct changes" do
    changeset = ASPK.Token.creation_changeset()

    refute changeset.changes.id == nil
    refute changeset.changes.secret == nil
  end

  test "creation_changeset/0 inserts a hashed secret" do
    {:ok, token} = ASPK.Token.creation_changeset() |> ASPK.Repo.insert()
    refute token.hashed_secret == nil 
  end
end
