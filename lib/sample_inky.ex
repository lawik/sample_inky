defmodule SampleInky.SelfTest do
  def init(_) do
    IO.puts("Initializing inky...")
    state = Inky.init(:phat, :red)

    IO.puts("Rendering quadrants pixel data...")

    state =
      Enum.reduce(0..(state.display.height - 1), state, fn y, state ->
        Enum.reduce(0..(state.display.width - 1), state, fn x, state ->
          color =
            cond do
              x > state.display.width / 2 ->
                cond do
                  y > state.display.height / 2 ->
                    :red

                  true ->
                    cond do
                      rem(x, 2) == 0 -> :white
                      true -> :black
                    end
                end

              true ->
                cond do
                  y > state.display.height / 2 ->
                    :black

                  true ->
                    :white
                end
            end

          Inky.set_pixel(state, x, y, color)
        end)
      end)

    IO.puts("Pushing update to display...")
    IO.puts("(it should start blinking and take quite a few seconds)")
    state = Inky.show(state)
    {:ok, nil}
  end
end
