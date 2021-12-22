defmodule TestWpool.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # When started with the provided method, killing the worker pool does not kill the application
    # :wpool.start_pool(:poolz, [{:worker, {TestWpool.Worker, []}}, {:workers, 5}])
    children = [
      {TestWpool.Supervisor, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end
end
