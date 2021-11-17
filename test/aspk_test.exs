defmodule ASPKTest do
  use ASPK.RepoCase

  setup do
    [encoded_token: ASPK.create_token!()]
  end

  describe "the high level API" do
    test "create_token/0 generates a token" do
      assert {:ok, "Basic " <> _encoded_user_and_pass} = ASPK.create_token()
    end

    test "tokens generated using create_token!/0 can be decoded", %{
      encoded_token: encoded_token,
      conn: conn
    } do
      assert {id, _encoded_token} =
               conn
               |> Plug.Conn.put_req_header("authorization", encoded_token)
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
    test "a request with no token returns a 401", %{conn: conn} do
      conn = ASPK.Authentication.call(conn, [])
      assert :sent = conn.state
      assert 401 = conn.status
      refute [] == Plug.Conn.get_resp_header(conn, "www-authenticate")
    end

    test "a request with a valid token returns 204", %{encoded_token: encoded_token, conn: conn} do
      conn =
        conn
        |> Plug.Conn.put_req_header("authorization", encoded_token)
        |> ASPK.Authentication.call([])

      assert :sent = conn.state
      assert 204 = conn.status
    end

    test "a request with an invalid token returns a 403", %{
      conn: conn,
      encoded_token: encoded_token
    } do
      {id, _} =
        conn
        |> Plug.Conn.put_req_header("authorization", encoded_token)
        |> Plug.BasicAuth.parse_basic_auth()

      conn =
        conn
        |> Plug.Conn.put_req_header("authorization", Plug.BasicAuth.encode_basic_auth(id, "bogus"))
        |> ASPK.Authentication.call([])

      assert :sent = conn.state
      assert 403 = conn.status
    end
  end
end
