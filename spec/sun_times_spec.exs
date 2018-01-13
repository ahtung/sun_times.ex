defmodule SunTimesSpec do
  use ESpec
  use Timex
  
  doctest SunTimes
  
  let :day, do: Timex.to_datetime({2010, 3, 8}, "Etc/UTC")
  let :latitude, do: 43.779
  let :longitude, do: 11.432
  let :rise, do: Timex.to_datetime({{2010, 3, 8}, {5, 39, 53}}, "Etc/UTC")
  let :set, do: Timex.to_datetime({{2010, 3, 8}, {17, 11, 16}}, "Etc/UTC")

  it "rise" do
    expect(SunTimes.rise(day(), latitude(), longitude())).to be_close_to(rise(), {:minutes, 100})
  end
  
  it "set" do
    expect(SunTimes.set(day(), latitude(), longitude())).to be_close_to(set(), {:minutes, 100})
  end
end
