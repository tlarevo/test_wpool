defmodule TestWpool.Supervisor do
  use Supervisor

  @moduledoc """
  Simple supervisor
  """
  @spec start_link(any()) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(args \\ [name: __MODULE__]) do
    Supervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  def child_spec(args) do
    %{id: __MODULE__,
      start: {__MODULE__, :start_link, args},
      restart: :permanent,
      shutdown: 5000,
      type: :supervisor,
      modules: []
    }
  end

  @impl true
  def init(_init_arg) do
    children = [
      %{
        id: :wpool_pool,
        start: {:wpool_pool, :start_link, [:err_pool, [{:worker, {TestWpool.Worker, []}}, {:workers, 1}, {:queue_type, :lifo}, {:pool_sup_shutdown, :infinity}]]},
        restart: :permanent,
        shutdown: 5000,
        type: :supervisor,
        modules: []
      }
    ]

    opts = [strategy: :one_for_one]
    Supervisor.init(children, opts)
  end

end
