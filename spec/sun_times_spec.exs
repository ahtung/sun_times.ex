defmodule SunTimesSpec do
  use ESpec
  
  let :day, do: nil#%DateTime{year: 2010, month: 3, day: 8}#(2010, 3, 8)
  let :latitude, do: 43.779
  let :longitude, do: 11.432
  
  it "works" do
    expect(SunTimes.rise(day, latitude, longitude)).to eq(:world)
  end
end
