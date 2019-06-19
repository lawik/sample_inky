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
      command_mod: Application.get_env(:inky, :command_module)
    })
    # state = Inky.init(:phat, :red)

    IO.puts("Rendering quadrants pixel data...")

    Inky.set_pixels(pid, fn x, y, w, h, _acc ->
      cond do
        x > w / 2 ->
          cond do
            y > h / 2 ->
              :red

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
    # state =
    #   Enum.reduce(0..(state.display.height - 1), state, fn y, state ->
    #     Enum.reduce(0..(state.display.width - 1), state, fn x, state ->
    #       color =
    #         cond do
    #           x > state.display.width / 2 ->
    #             cond do
    #               y > state.display.height / 2 ->
    #                 :red

    #               true ->
    #                 cond do
    #                   rem(x, 2) == 0 -> :white
    #                   true -> :black
    #                 end
    #             end

    #           true ->
    #             cond do
    #               y > state.display.height / 2 ->
    #                 :black

    #               true ->
    #                 :white
    #             end
    #         end

    #       # Inky.set_pixel(state, x, y, color)
    #     end)
    #   end)

    IO.puts("Pushing update to display...")
    IO.puts("(it should start blinking and take quite a few seconds)")
    # Inky.show(pid)

    # Striped

    # state =
    #   Enum.reduce(0..(state.display.height - 1), state, fn y, state ->
    #     Enum.reduce(0..(state.display.width - 1), state, fn x, state ->
    #       color =
    #         cond do
    #           rem(x, 2) == 0 -> :white
    #           true -> :black
    #         end

    #       Inky.set_pixel(state, x, y, color)
    #     end)
    #   end)

    # state = Inky.show(state)
    :timer.sleep(10000)
    {:ok, pid}
  end
end
