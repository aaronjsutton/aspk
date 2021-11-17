defmodule ASPK.Authentication do
  import Plug.Conn
  import Plug.BasicAuth

  require Logger

  def init(options), do: options

  @doc """
  Pluggable authentication logic module.
  """
  def call(conn, _opts) do
    with {id, secret} <- parse_basic_auth(conn) do
      Logger.info("Processing authentication request for key: #{id}")

      valid? =
        ASPK.Token
        |> ASPK.Repo.get(id)
        |> ASPK.Token.valid_secret?(secret)

      if valid? do
        send_resp(conn, 204, "")
      else
        send_resp(conn, 403, "")
      end
    else
      _ ->
        conn
        |> request_basic_auth(realm: "Access to protected resources")
        |> send_resp()
    end
  end
end
