defmodule PythonInElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PythonInElixirWeb.Telemetry,
      PythonInElixir.Repo,
      {DNSCluster, query: Application.get_env(:python_in_elixir, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PythonInElixir.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PythonInElixir.Finch},
      # Start a worker by calling: PythonInElixir.Worker.start_link(arg)
      # {PythonInElixir.Worker, arg},
      # Start to serve requests, typically the last entry
      PythonInElixirWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PythonInElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PythonInElixirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
