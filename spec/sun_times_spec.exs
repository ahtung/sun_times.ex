defmodule SunTimesSpec do
  use ESpec
  use Timex
  
  doctest SunTimes
  
  let :day, do: Timex.to_date({2010, 3, 8})
  let :latitude, do: 43.779
  let :longitude, do: 11.432
  let :rise, do:  Timex.to_date({2010, 3, 8, 5, 39, 53})
  
  it "rise" do
    expect(SunTimes.rise(day(), latitude(), longitude())).to be_close_to(Timex.now, {:minutes, 1})
  end
end
