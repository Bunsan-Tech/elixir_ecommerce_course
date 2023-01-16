import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ecommerce_course, EcommerceCourse.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "ecommerce_course_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ecommerce_course, EcommerceCourseWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "pzGJl5L3VAuLhOn/BeGgfKhDHxYrr3+3PwnTUPd8HAt8zrUcDKbB0uV0Dfpv5n/N",
  server: false

# In test we don't send emails.
config :ecommerce_course, EcommerceCourse.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
