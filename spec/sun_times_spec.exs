defmodule SunTimesSpec do
  use ESpec
  use Timex

  doctest SunTimes

  let :tolerance, do: {:minutes, 3}

  describe "Amsterdam" do
    let :lat, do: 52.3702
    let :lon, do: 4.8952
    let :timezone, do: "Europe/Amsterdam"

    describe "on Jan 14th 2018" do
      let :day, do: Timex.to_datetime({2018 , 1, 14}, timezone())

      it "rise" do
        rise = Timex.to_datetime({{2018, 1, 14}, {8, 44, 00}}, timezone())

        expect(SunTimes.rise(day(), lat(), lon())).to be_close_to(rise, tolerance())
      end

      it "set" do
        set = Timex.to_datetime({{2018, 1, 14}, {16, 55, 00}}, timezone())

        expect(SunTimes.set(day(), lat(), lon())).to be_close_to(set, tolerance())
      end
    end

    describe "on Jan 30th 2017" do
      let :day, do: Timex.to_datetime({2017 , 1, 30}, timezone())

      it "rise" do
        rise = Timex.to_datetime({{2017, 1, 30}, {8, 24, 00}}, timezone())

        expect(SunTimes.rise(day(), lat(), lon())).to be_close_to(rise, tolerance())
      end

      it "set" do
        set = Timex.to_datetime({{2017, 1, 30}, {17, 23, 00}}, timezone())

        expect(SunTimes.set(day(), lat(), lon())).to be_close_to(set, tolerance())
      end
    end

    describe "on May 11th 1984" do
      let :day, do: Timex.to_datetime({1984 , 5, 11}, timezone())

      it "rise" do
        rise = Timex.to_datetime({{1984, 5, 11}, {5, 51, 00}}, timezone())

        expect(SunTimes.rise(day(), lat(), lon())).to be_close_to(rise, tolerance())
      end

      it "set" do
        set = Timex.to_datetime({{1984, 5, 11}, {21, 23, 00}}, timezone())

        expect(SunTimes.set(day(), lat(), lon())).to be_close_to(set, tolerance())
      end
    end
  end

  describe "Istanbul" do
    let :lat, do: 41.0082
    let :lon, do: 28.9784
    let :timezone, do: "Europe/Istanbul"

    describe "on Jan 14th 2018" do
      let :day, do: Timex.to_datetime({2018 , 1, 14}, timezone())

      it "rise" do
        rise = Timex.to_datetime({{2018, 1, 14}, {8, 27, 00}}, timezone())

        expect(SunTimes.rise(day(), lat(), lon())).to be_close_to(rise, tolerance())
      end

      it "set" do
        set = Timex.to_datetime({{2018, 1, 14}, {17, 59, 00}}, timezone())

        expect(SunTimes.set(day(), lat(), lon())).to be_close_to(set, tolerance())
      end
    end

    describe "on May 11th 1984" do
      let :day, do: Timex.to_datetime({1984 , 5, 11}, timezone())

      it "rise" do
        rise = Timex.to_datetime({{1984, 5, 11}, {5, 50, 00}}, timezone())

        expect(SunTimes.rise(day(), lat(), lon())).to be_close_to(rise, tolerance())
      end

      it "set" do
        set = Timex.to_datetime({{1984, 5, 11}, {20, 11, 00}}, timezone())

        expect(SunTimes.set(day(), lat(), lon())).to be_close_to(set, tolerance())
      end
    end
  end

  describe "Ny-Ålesund" do
    let :lat, do: 78.959137
    let :lon, do: 11.4599269
    let :timezone, do: "Europe/Amsterdam"

    describe "on Jan 1st 2018" do
      let :day, do: Timex.to_datetime({2018, 1, 1}, timezone())

      it "rise" do
        expect(SunTimes.rise(day(), lat(), lon())).to eq({:error, "Never rises"})
      end

      it "set" do
        expect(SunTimes.set(day(), lat(), lon())).to eq({:error, "Never rises"})
      end
    end

    describe "on Aug 1st 2018" do
      let :day, do: Timex.to_datetime({2018, 8, 1}, timezone())

      it "rise" do
        expect(SunTimes.rise(day(), lat(), lon())).to eq({:error, "Never sets"})
      end

      it "set" do
        expect(SunTimes.set(day(), lat(), lon())).to eq({:error, "Never sets"})
      end
    end
  end
end
