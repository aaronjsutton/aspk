defmodule ASPK.Authentication do
  import Plug.Conn

  require Logger

  def init(options), do: options

  @doc """
  Primary authentication logic controller.
  """
  def call(conn, _opts) do
    with {id, secret} <- Plug.BasicAuth.parse_basic_auth(conn) do
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
      _ -> send_resp(conn, 401, "")
    end
  end
end
