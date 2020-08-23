defmodule BstServer.Application do
  use Application
  require Logger
  @port 6543

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: BstServer.Controller.Router, options: [port: @port]}
    ]
    opts = [strategy: :one_for_one, name: BstServer.Supervisor]

    Logger.info("Starting application... Listening at #{@port}")

    Supervisor.start_link(children, opts)
  end
end