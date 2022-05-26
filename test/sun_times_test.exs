ExUnit.start()

defmodule SunTimesTest do
  use ExUnit.Case

  defp testDate(), do: DateTime.new!(~D[2022-05-26], ~T[00:00:00], "Etc/UTC")

  describe "rise/3" do
    test "offsets of minus 15 degrees should adjust sunrise by aprox 1 hour forward" do
      assert SunTimes.rise(testDate(), 41.00, -70.0-15)
      |> DateTime.diff(SunTimes.rise(testDate(), 41.00, -70.0)
      |> DateTime.add(3600, :second),:second)
      |> Kernel.abs() <= 20
    end
    test "offsets of plus 15 degrees should adjust sunrise by aprox 1 hour backward" do
      assert SunTimes.rise(testDate(), 41.00, -70.0+15)
      |> DateTime.diff(SunTimes.rise(testDate(), 41.00, -70.0)
      |> DateTime.add(-3600, :second),:second)
      |> Kernel.abs() <= 20
    end
  end

  describe "set/3" do
    test "offsets of minus 15 degrees should adjust sunset by aprox 1 hour forward" do
      assert SunTimes.set(testDate(), 41.00, -70.0-15)
      |> DateTime.diff(SunTimes.set(testDate(), 41.00, -70.0)
      |> DateTime.add(3600, :second),:second)
      |> Kernel.abs() <= 20
    end
    test "offsets of plus 15 degrees should adjust sunset by aprox 1 hour backward" do
      assert SunTimes.set(testDate(), 41.00, -70.0+15)
      |> DateTime.diff(SunTimes.set(testDate(), 41.00, -70.0)
      |> DateTime.add(-3600, :second),:second)
      |> Kernel.abs() <= 20
    end
  end
end
