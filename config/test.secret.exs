use Mix.Config

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: "GOOGLE_CLIENT_ID",
  client_secret: "GOOGLE_SECRET"

config :rollbax,
  access_token: "ACCESS_TOKEN",
  environment: "development"
