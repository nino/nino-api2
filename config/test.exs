import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phoenix_api, PhoenixApiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "OgWv+U7a4+7wCaf5DJ0iSJQfvH9R2wZ5QvZCgvpt99qwu7Q4H7FFEYzhCEq5SjQe",
  server: false

# In test we don't send emails.
config :phoenix_api, PhoenixApi.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
