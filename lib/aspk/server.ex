defmodule ASPK.Server do
  require Logger

  def start_link(port: port, dispatch: dispatch) do
    {:ok, socket} = :gen_tcp.listen(port, active: false, packet: :http_bin, reuseaddr: true)

    Logger.info("Starting ASPK server version #{ASPK.version()}")
    Logger.info("Accepting authentication requests on port #{port}")

    {:ok, spawn_link(ASPK.Server, :accept, [socket, dispatch])}
  end

  def accept(socket, dispatch) do
    {:ok, request} = :gen_tcp.accept(socket)
    spawn(fn -> dispatch.(request) end)
    accept(socket, dispatch)
  end

  def send_response(socket, response) do
    :gen_tcp.send(socket, response)
    :gen_tcp.close(socket)
  end

  def child_spec(opts) do
    %{id: ASPK.Server, start: {ASPK.Server, :start_link, [opts]}}
  end

  def read_request(request, acc \\ %{headers: []}) do
    case :gen_tcp.recv(request, 0) do
      {:ok, {:http_request, :GET, {:abs_path, full_path}, _}} ->
        read_request(request, Map.put(acc, :full_path, full_path))

      {:ok, :http_eoh} ->
        acc

      {:ok, {:http_header, _, key, _, value}} ->
        read_request(
          request,
          Map.put(acc, :headers, [{String.downcase(to_string(key)), value} | acc.headers])
        )

      {:ok, _line} ->
        read_request(request, acc)
    end
  end
end
