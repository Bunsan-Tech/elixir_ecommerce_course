defmodule EcommerceCourse.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      EcommerceCourse.Repo,
      # Start the Telemetry supervisor
      EcommerceCourseWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: EcommerceCourse.PubSub},
      # Start the Endpoint (http/https)
      EcommerceCourseWeb.Endpoint
      # Start a worker by calling: EcommerceCourse.Worker.start_link(arg)
      # {EcommerceCourse.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EcommerceCourse.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EcommerceCourseWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
