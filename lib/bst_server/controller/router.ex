defmodule BstServer.Controller.Router do
  @moduledoc """
  Controller module for BST application.
  Users can insert element to a bst and endpoint returns the tree in a pre_order format.
  """
  use Plug.Router
  use Plug.ErrorHandler
  alias BstServer.Modules.Bst, as: Bst

  require Logger

  plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug :match
  plug :dispatch

  @doc """
  Insert element `n` into a given `tree`

  Returns pre_order format tree result.
  """
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
    send_resp(conn, 404, "Oops! the server is only responding to /insert and /status")
  end

  defp handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
    Logger.error(kind)
    Logger.error(reason)
    Logger.error(stack)
    send_resp(conn, conn.status, Poison.encode!(reason))
  end
end
