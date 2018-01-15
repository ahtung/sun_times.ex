defmodule SunTimesSpec do
  use ESpec
  use Timex

  doctest SunTimes

  let :tolerance, do: {:minutes, 3}
  let :timezone, do: "Etc/UTC"

  describe "Amsterdam" do
    let :lat, do: 52.3702
    let :lon, do: 4.8952

    describe "on Jan 14th 2018" do
      let :day, do: Timex.to_date({2018 , 1, 14})

      it "rise" do
        rise = Timex.to_datetime({{2018, 1, 14}, {7, 44, 00}}, timezone())

        expect(SunTimes.rise(day(), lat(), lon())).to be_close_to(rise, tolerance())
      end

      it "set" do
        set = Timex.to_datetime({{2018, 1, 14}, {15, 55, 00}}, timezone())

        expect(SunTimes.set(day(), lat(), lon())).to be_close_to(set, tolerance())
      end
    end

    describe "on Jan 30th 2017" do
      let :day, do: Timex.to_date({2017 , 1, 30})

      it "rise" do
        rise = Timex.to_datetime({{2017, 1, 30}, {7, 24, 00}}, timezone())

        expect(SunTimes.rise(day(), lat(), lon())).to be_close_to(rise, tolerance())
      end

      it "set" do
        set = Timex.to_datetime({{2017, 1, 30}, {16, 23, 00}}, timezone())

        expect(SunTimes.set(day(), lat(), lon())).to be_close_to(set, tolerance())
      end
    end

    describe "on May 11th 1984" do
      let :day, do: Timex.to_date({1984 , 5, 11})

      it "rise" do
        rise = Timex.to_datetime({{1984, 5, 11}, {3, 51, 00}}, timezone())

        expect(SunTimes.rise(day(), lat(), lon())).to be_close_to(rise, tolerance())
      end

      it "set" do
        set = Timex.to_datetime({{1984, 5, 11}, {19, 23, 00}}, timezone())

        expect(SunTimes.set(day(), lat(), lon())).to be_close_to(set, tolerance())
      end
    end
  end

  describe "Istanbul" do
    let :lat, do: 41.0082
    let :lon, do: 28.9784

    describe "on Jan 14th 2018" do
      let :day, do: Timex.to_date({2018 , 1, 14})

      it "rise" do
        rise = Timex.to_datetime({{2018, 1, 14}, {5, 27, 00}}, timezone())

        expect(SunTimes.rise(day(), lat(), lon())).to be_close_to(rise, tolerance())
      end

      it "set" do
        set = Timex.to_datetime({{2018, 1, 14}, {14, 59, 00}}, timezone())

        expect(SunTimes.set(day(), lat(), lon())).to be_close_to(set, tolerance())
      end
    end

    describe "on May 11th 1984" do
      let :day, do: Timex.to_date({1984 , 5, 11})

      it "rise" do
        rise = Timex.to_datetime({{1984, 5, 11}, {2, 50, 00}}, timezone())

        expect(SunTimes.rise(day(), lat(), lon())).to be_close_to(rise, tolerance())
      end

      it "set" do
        set = Timex.to_datetime({{1984, 5, 11}, {17, 11, 00}}, timezone())

        expect(SunTimes.set(day(), lat(), lon())).to be_close_to(set, tolerance())
      end
    end
  end

  describe "Kuala Lumpur" do
    let :lat, do: 3.1385036
    let :lon, do: 101.6169495

    describe "on Jan 16th 2018" do
      let :day, do: Timex.to_date({2018 , 1, 16})

      it "rise" do
        rise = Timex.to_datetime({{2018 , 1, 16}, {23, 24, 00}}, timezone())

        expect(SunTimes.rise(day(), lat(), lon())).to be_close_to(rise, tolerance())
      end

      it "set" do
        set = Timex.to_datetime({{2018 , 1, 16}, {11, 21, 00}}, timezone())

        expect(SunTimes.set(day(), lat(), lon())).to be_close_to(set, tolerance())
      end
    end
  end

  describe "Iowa City" do
    let :lat, do: 41.6470476
    let :lon, do: -91.5743827

    describe "on Jan 15th 2018" do
      let :day, do: Timex.to_date({2018 , 1, 15})

      it "rise" do
        rise = Timex.to_datetime({{2018 , 1, 15}, {13, 30, 00}}, timezone())

        expect(SunTimes.rise(day(), lat(), lon())).to be_close_to(rise, tolerance())
      end

      it "set" do
        set = Timex.to_datetime({{2018 , 1, 15}, {23, 00, 00}}, timezone())

        expect(SunTimes.set(day(), lat(), lon())).to be_close_to(set, tolerance())
      end
    end
  end

  describe "Fairbanks" do
    let :lat, do: 64.828348
    let :lon, do: -147.7390413

    describe "on Jan 15th 2018" do
      let :day, do: Timex.to_date({2018 , 1, 15})

      it "rise" do
        rise = Timex.to_datetime({{2018 , 1, 15}, {19, 25, 00}}, timezone())

        expect(SunTimes.rise(day(), lat(), lon())).to be_close_to(rise, tolerance())
      end

      it "set" do
        set = Timex.to_datetime({{2018 , 1, 15}, {00, 35, 00}}, timezone())

        expect(SunTimes.set(day(), lat(), lon())).to be_close_to(set, tolerance())
      end
    end
  end

  describe "Ny-Ålesund" do
    let :lat, do: 78.959137
    let :lon, do: 11.4599269
    let :timezone, do: "Europe/Amsterdam"

    describe "on Jan 1st 2018" do
      let :day, do: Timex.to_date({2018, 1, 1})

      it "rise" do
        expect(SunTimes.rise(day(), lat(), lon())).to eq({:error, "Never rises"})
      end

      it "set" do
        expect(SunTimes.set(day(), lat(), lon())).to eq({:error, "Never rises"})
      end
    end

    describe "on Aug 1st 2018" do
      let :day, do: Timex.to_date({2018, 8, 1})

      it "rise" do
        expect(SunTimes.rise(day(), lat(), lon())).to eq({:error, "Never sets"})
      end

      it "set" do
        expect(SunTimes.set(day(), lat(), lon())).to eq({:error, "Never sets"})
      end
    end
  end
end
