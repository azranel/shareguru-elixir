use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :shareguru, Shareguru.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :shareguru, Shareguru.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "shareguru_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

import_config("test.secret.exs")
