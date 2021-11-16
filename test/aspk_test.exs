defmodule ASPKTest do
  use ASPK.RepoCase

  describe "the high level API" do
    test "create_token/0 generates a token" do
      {id, _} = ASPK.create_token!() |> ASPK.Token.parse()

      refute ASPK.Repo.get(ASPK.Token, id) == nil
    end

    test "revoke_token/1 removes a token from the database" do
      {id, _} = ASPK.create_token!() |> ASPK.Token.parse()
    end
  end
end
