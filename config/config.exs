# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config
require Logger

# Configures the endpoint
config :phoenix_logger_test, PhoenixLoggerTest.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "09IEzc7CVnFAhcYhjHmJTltytWs4PRR6Lp69YoVzF7ai9rdoZBFH0tsyR4t23xIg",
  render_errors: [view: PhoenixLoggerTest.ErrorView, accepts: ~w(json)],
  pubsub: [name: PhoenixLoggerTest.PubSub,
           adapter: Phoenix.PubSub.PG2],
  debug_errors: false,
  code_reloader: true,
  http: [
    protocol_options: [
      onrequest: (fn(req) ->
        Logger.warn "XXXXXXXX ON REQUEST XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
        req
      end),
      onresponse: (fn(status,headers,body,req) ->
        Logger.warn "XXXXXXXX ON RESPONSE XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
        req
      end)
    ]
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
