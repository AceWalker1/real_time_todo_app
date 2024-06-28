defmodule RealTimeTodoApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RealTimeTodoAppWeb.Telemetry,
      RealTimeTodoApp.Repo,
      {DNSCluster, query: Application.get_env(:real_time_todo_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: RealTimeTodoApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: RealTimeTodoApp.Finch},
      # Start a worker by calling: RealTimeTodoApp.Worker.start_link(arg)
      # {RealTimeTodoApp.Worker, arg},
      # Start to serve requests, typically the last entry
      RealTimeTodoAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RealTimeTodoApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RealTimeTodoAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
