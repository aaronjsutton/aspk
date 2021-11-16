defmodule ASPK.Authentication do
  import Plug.Conn
  import Plug.BasicAuth
  
  require Logger

  def init(options), do: options

  def call(conn, _opts) do
    Logger.info(conn)

    conn
    |> send_resp(204, "")
  end
end
