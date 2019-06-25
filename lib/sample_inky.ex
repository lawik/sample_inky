defmodule SampleInky.SelfTest do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, [])
  end

  @impl true
  @spec init(any) :: {:ok, pid}
  def init(_) do
    IO.puts("Initializing inky...")

    {:ok, pid } = Inky.start_link(%{
      type: :phat,
      accent: :red,
      # Use the configured module if available, otherwise RpiHAL
      hal_mod: Application.get_env(:inky, :hal_module, Inky.RpiHAL)
    })

    IO.puts("Rendering quadrants pixel data...")

    Inky.set_pixels(pid, fn x, y, w, h, _acc ->
      cond do
        x > w / 2 ->
          cond do
            y > h / 2 ->
              :accent

            true ->
              cond do
                rem(x, 2) == 0 -> :white
                true -> :black
              end
          end

        true ->
          cond do
            y > h / 2 ->
              :black

            true ->
              :white
          end
      end
    end)

    IO.puts("Pushing update to display...")

    {:ok, pid}
  end
end
