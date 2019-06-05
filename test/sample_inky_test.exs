defmodule SampleInkyTest do
  use ExUnit.Case
  doctest SampleInky

  test "greets the world" do
    assert SampleInky.hello() == :world
  end
end
