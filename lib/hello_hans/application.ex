defmodule HelloHans.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    HelloHans.Release.migrate()
    children = [
      # Start the Telemetry supervisor
      HelloHansWeb.Telemetry,
      # Start the Ecto repository
      HelloHans.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: HelloHans.PubSub},
      # Start Finch
      {Finch, name: HelloHans.Finch},
      # Start the Endpoint (http/https)
      HelloHansWeb.Endpoint
      # Start a worker by calling: HelloHans.Worker.start_link(arg)
      # {HelloHans.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloHans.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HelloHansWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
