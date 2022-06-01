ExUnit.start()

defmodule SunTimesTest do
  use ExUnit.Case

  defmodule TestHelpers do
    def testDate() do
      DateTime.new!(~D[2022-05-26], ~T[00:00:00], "Etc/UTC")
    end

    def compareUTCArrays(arr1, arr2, tolerance) do
      -11..11
      |> Enum.map(fn hour ->
        assert abs(
                 DateTime.diff(
                   Enum.at(arr1, hour),
                   Enum.at(arr2, hour),
                   :second
                 )
               ) <= tolerance
      end)
    end

    def loopThroughTimeZones(lat, lon, event, offset) do
      if event == :set do
        -11..11
        |> Enum.map(fn hour ->
          SunTimes.set(testDate(), lat, lon + hour * 15)
          |> DateTime.add(-offset * 3600, :second)
        end)
      else
        -11..11
        |> Enum.map(fn hour ->
          SunTimes.rise(testDate(), lat, lon + hour * 15)
          |> DateTime.add(-offset * 3600, :second)
        end)
      end
    end
  end

  describe "rise/3" do
    test "offsets of +/- 15 degrees should adjust sunrise by aprox 1 hour" do
      assert TestHelpers.compareUTCArrays(
               TestHelpers.loopThroughTimeZones(30, -10, :rise, 0),
               TestHelpers.loopThroughTimeZones(30, 5, :rise, -1),
               50
             )
    end
  end

  describe "set/3" do
    test "offsets of +/- 15 degrees should adjust sunset by aprox 1 hour" do
      assert TestHelpers.compareUTCArrays(
               TestHelpers.loopThroughTimeZones(30, -10, :set, 0),
               TestHelpers.loopThroughTimeZones(30, 5, :set, -1),
               50
             )
    end
  end

  describe "relationship of sunset to sunrise" do
    test "for all longitudes sunset should be after sunrise" do
      rise = TestHelpers.loopThroughTimeZones(30, 5, :rise, 0)
      set = TestHelpers.loopThroughTimeZones(30, 5, :set, 0)

      -12..11
      |> Enum.each(fn hour ->
        assert DateTime.diff(
                 Enum.at(set, hour),
                 Enum.at(rise, hour),
                 :second
               ) >= 0
      end)
    end
  end
end
