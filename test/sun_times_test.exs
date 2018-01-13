defmodule SunTimesTest do
  use ExUnit.Case
  doctest SunTimes

  test "greets the world" do
    assert SunTimes.hello() == :world
  end
end
