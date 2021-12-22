defmodule TestWpool.Worker do
  use GenServer



  def child_spec(args) do
    %{id: __MODULE__,
      start: {__MODULE__, :start_link, args},
      restart: :permanent,
      shutdown: 5000,
      type: :worker,
      modules: []
    }
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:do_work, _from, state) do
    {:reply, :done, state}
  end

  @impl true
  def handle_cast(:do_work, state) do
    IO.puts("DONE!!!")
    {:noreply, state}
  end
end
