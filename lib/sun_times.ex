defmodule SunTimes do
  @moduledoc """
  Documentation for SunTimes.
  """
  @default_zenith 90.83333
  @degrees_per_hour 360.0 / 24.0

  @doc """
  Calculates the sunrise.
  """
  def rise(date, lat, lon) do
    calculate(:rise, date, lat, lon)
  end

  @doc """
  Calculates the sunset.
  """
  def set(date, lat, lon) do
    calculate(:set, date, lat, lon)
  end

  defp calculate(event, date, lat, lon) do
    datetime = date |> Timex.to_datetime
    # lngHour
    longitude_hour = lon / @degrees_per_hour

    # t
    base_time =
      if event == :rise, do: 6.0, else: 18.0

    approximate_time = day_of_year(datetime) + (base_time - longitude_hour) / 24.0

    # M
    mean_sun_anomaly = (0.9856 * approximate_time) - 3.289

    # L
    sun_true_longitude = mean_sun_anomaly +
                        (1.916 * Math.sin(Math.deg2rad(mean_sun_anomaly))) +
                        (0.020 * Math.sin(2 * Math.deg2rad(mean_sun_anomaly))) +
                        282.634
    sun_true_longitude = coerce_degrees(sun_true_longitude)

    # RA
    tan_right_ascension = 0.91764 * Math.tan(Math.deg2rad(sun_true_longitude))
    sun_right_ascension = Math.rad2deg(Math.atan(tan_right_ascension))
    sun_right_ascension = coerce_degrees(sun_right_ascension)

    # right ascension value needs to be in the same quadrant as L
    sun_true_longitude_quadrant  = Float.floor(sun_true_longitude  / 90.0) * 90.0
    sun_right_ascension_quadrant = Float.floor(sun_right_ascension / 90.0) * 90.0
    sun_right_ascension = sun_right_ascension + (sun_true_longitude_quadrant - sun_right_ascension_quadrant)

    # RA = RA / 15
    sun_right_ascension_hours = sun_right_ascension / @degrees_per_hour

    sin_declination = 0.39782 * Math.sin(Math.deg2rad(sun_true_longitude))
    cos_declination = Math.cos(Math.asin(sin_declination))

    cos_local_hour_angle =
      (Math.cos(Math.deg2rad(@default_zenith)) - (sin_declination * Math.sin(Math.deg2rad(lat)))) /
      (cos_declination * Math.cos(Math.deg2rad(lat)))
    # the sun never rises on this location (on the specified date)
    if cos_local_hour_angle > 1 do
      {:error, "Never rises"}
    else
      # # the sun never sets on this location (on the specified date)
      if cos_local_hour_angle < -1 do
        {:error, "Never sets"}
      else
        # H
        suns_local_hour =
          if event == :rise do
            360 - Math.rad2deg(Math.acos(cos_local_hour_angle))
          else
            Math.rad2deg(Math.acos(cos_local_hour_angle))
          end
        # H = H / 15
        suns_local_hour_hours = suns_local_hour / @degrees_per_hour

        # T = H + RA - (0.06571 * t) - 6.622
        local_mean_time = suns_local_hour_hours + sun_right_ascension_hours - (0.06571 * approximate_time) - 6.622

        # Convert sunset's negative local time to positive number of hours
        local_mean_time = if event == :set, do: local_mean_time + 24, else: local_mean_time

        # UT = T - lngHour
        gmt_hours = local_mean_time - longitude_hour

        # If gmt_hours > 24 or < 0 wrap hours and update date
        {gmt_hours, datetime} = if gmt_hours > 24, do: {gmt_hours - 24.0, next_day(datetime)}, else: {gmt_hours, datetime}
        {gmt_hours, datetime} = if gmt_hours < 0, do: {gmt_hours + 24.0, prev_day(datetime)}, else: {gmt_hours, datetime}

        hour = Float.floor(gmt_hours)
        hour_remainder = (gmt_hours - hour) * 60.0
        minute = Float.floor(hour_remainder)
        seconds = Float.floor((hour_remainder - minute) * 60.0)

        Timex.to_datetime({{datetime.year, datetime.month, datetime.day}, {round(hour), round(minute), round(seconds)}}, "Etc/UTC")
      end
    end
  end

  defp coerce_degrees(d) when d < 0, do: coerce_degrees(d + 360)
  defp coerce_degrees(d) when d >= 360, do: coerce_degrees(d - 360)
  defp coerce_degrees(d), do: d

  defp day_of_year(d) do
    {_, week} = :calendar.iso_week_number({d.year, d.month, d.day})
    ((week - 1) * 7) + (:calendar.day_of_the_week(d.year, d.month, d.day))
  end

  defp next_day(datetime) do
    Timex.shift(datetime, days: 1)
      |> Timex.to_date
  end

  defp prev_day(datetime) do
    Timex.shift(datetime, days: -1)
      |> Timex.to_date
  end

  defp to_datetime(d) do
    t = Timex.now
    d
      |> Timex.to_datetime
      |> Timex.shift(hour: t.hour, minute: t.minute, second: t.second)
  end
end
