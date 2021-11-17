defmodule ASPKTest do
  use ASPK.RepoCase

  setup context do
    [encoded_token: ASPK.create_token!()]
  end

  describe "the high level API" do
    test "create_token/0 generates a token" do
      assert {:ok, "Basic " <> _encoded_user_and_pass} = ASPK.create_token()
    end

    test "tokens generated using create_token!/0 can be decoded", %{
      encoded_token: token,
      conn: conn
    } do
      assert {id, token} = conn
      |> Plug.Conn.put_req_header("authorization", token)
      |> Plug.BasicAuth.parse_basic_auth()

      key = ASPK.Repo.get(ASPK.Token, id)

      refute key == nil
    end

    test "revoke_token/1 removes a token from the database" do
      {:ok, token} = ASPK.Token.creation_changeset() |> ASPK.Repo.insert()
      assert {:ok, _} = ASPK.revoke_token(Repo.get!(ASPK.Token, token.id))
      assert nil == Repo.get(ASPK.Token, token.id)
    end
  end

  describe "integration test" do

  end
end
