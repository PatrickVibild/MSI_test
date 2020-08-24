defmodule BstServer.Controller.Router do
  @moduledoc false
  use Plug.Router
  use Plug.ErrorHandler
  alias BstServer.Modules.Bst, as: Bst

  require Logger


  alias BstServer.Controller.VerifyRequest

  plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug :match
  plug :dispatch


  post "/insert" do
    Logger.info("Inserting value on bst")
    {status, body} =
      case conn.body_params do
        %{"tree" => tree, "n" => n} -> {200, Bst.add(tree, n) |> Bst.pre_order}
        %{"tree" => _}              -> {400, %{response: "Missing n in json"}}
        %{"n" => _}                 -> {400, %{response: "Missing tree in json"}}
        _                           -> {400, %{response: "Tree and n is required"}}
      end
    send_resp(conn, status, Poison.encode!(body))
  end

  get "/status" do
    Logger.info("Requesting server status.")
    send_resp(conn, 200, "Healthy")
  end

  match _ do
    Logger.info("Page not found!")
    send_resp(conn, 404, "Oops! the server is only responding to /insert")
  end

  defp handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
    Logger.error(kind)
    Logger.error(reason)
    Logger.error(stack)
    send_resp(conn, conn.status, Poison.encode!(reason))
  end
end
