defmodule BstServer.Application do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: BstServer.Controller.Router, options: [port: cowboy_port()]}
    ]
    opts = [strategy: :one_for_one, name: BstServer.Supervisor]

    Logger.info("Starting application... Listening at #{cowboy_port()}")

    Supervisor.start_link(children, opts)
  end

  defp cowboy_port, do: Application.get_env(:BstServer, :cowboy_port, 8080)
end