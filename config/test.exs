import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :real_time_todo_app, RealTimeTodoApp.Repo,
  username: "postgres",
  password: "+254kibao",
  hostname: "localhost",
  database: "real_time_todo_app_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :real_time_todo_app, RealTimeTodoAppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "YgA1VQqu3GAWAsmajySNpWGg1M4zigWirVdmliPwTwADGrt4G2drzv/9WXDD7OPj",
  server: false

# In test we don't send emails.
config :real_time_todo_app, RealTimeTodoApp.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
