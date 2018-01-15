# SunTimes

[![Build Status](https://travis-ci.org/ahtung/sun_times.ex.svg?branch=master)](https://travis-ci.org/ahtung/sun_times.ex)
[![Coverage Status](https://coveralls.io/repos/ahtung/sun_times.ex/badge.svg?branch=master)](https://coveralls.io/r/ahtung/sun_times.ex?branch=master)
[![Hex.pm version](https://img.shields.io/hexpm/v/sun_times.svg?style=flat-square)](https://hex.pm/packages/sun_times)
[![Hex.pm downloads](https://img.shields.io/hexpm/dt/sun_times.svg)](https://hex.pm/packages/sun_times)

## Usage

In order to find the sunrise time in Amsterdam on the 14th of January:

```
lat = 52.3702
lon = 4.8952
day = Timex.to_datetime({2018 , 1, 14}, "Europe/Amsterdam")

SunTimes.rise(day, lat, lon)
```

Similarly, in order to find the sunset time in Amsterdam on the same day:

```
lat = 52.3702
lon = 4.8952
day = Timex.to_datetime({2018 , 1, 14}, "Europe/Amsterdam")

SunTimes.set(day, lat, lon)
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `sun_times` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:sun_times, "~> 0.1.1"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/sun_times](https://hexdocs.pm/sun_times).
