defmodule ASPK.TokenTest do
  use ASPK.RepoCase

  test "creation_changeset/0 creates a changeset with correct changes" do
    changeset = ASPK.Token.creation_changeset()

    refute changeset.changes.id == nil
    refute changeset.changes.secret == nil
  end

  test "creation_changeset/0 inserts a hashed secret" do
    {:ok, token} = ASPK.Token.creation_changeset() |> ASPK.Repo.insert()
    refute token.hashed_secret == nil
  end

  test "parse/1 correctly parses a token string" do
    token = ASPK.create_token!()
    assert {id, secret} = ASPK.Token.parse(token)
  end

  test "valid_secret?/2 validates a secret" do
    c = %Ecto.Changeset{changes: %{secret: secret}} = ASPK.Token.creation_changeset()
    {:ok, token} = ASPK.Repo.insert(c)
    assert true == token |> ASPK.Token.valid_secret?(secret)
  end
end
