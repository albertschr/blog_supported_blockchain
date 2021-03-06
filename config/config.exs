# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :blog,
  ecto_repos: [Blog.Repo]

# Configures the endpoint
config :blog, BlogWeb.Endpoint,
  url: [host: "localhost"],
  # secret_key_base: "EiKDxSZ/7GuGlTbV3fKfX8jDGYN2NSZXbVE+2m6suQrABHktDawL9TMktUpqiHaa",
  render_errors: [view: BlogWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Blog.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "6HlkIUvD"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Configures Guardian
config :blog, Auth.Guardian,
  issuer: "leeduckgo",
  secret_key: "HNinpKh9Ne3tr8BpjCpAEh0xzCqTIG3PWsfkR2AtzvUaRIpbs6oIQ9RcmjmGPekJ"

# Error handle
config :blog, Auth.AuthAccessPipeline,
  module: Auth.Guardian,
  error_handler: Auth.AuthErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
