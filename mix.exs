defmodule SunTimes.Mixfile do
  use Mix.Project

  def project do
    [
      app: :sun_times,
      version: "0.1.0",
      elixir: "~> 1.3",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      preferred_cli_env: [espec: :test, coveralls: :test],
      test_coverage: [tool: ExCoveralls, test_task: "espec"],
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:timex],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:espec, "~> 1.5.0", only: :test},
      {:excoveralls, "~> 0.8", only: :test},
      {:timex, "~> 3.1"},
      {:math, "~> 0.3.0"},
    ]
  end
end
