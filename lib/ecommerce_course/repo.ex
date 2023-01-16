defmodule EcommerceCourse.Repo do
  use Ecto.Repo,
    otp_app: :ecommerce_course,
    adapter: Ecto.Adapters.Postgres
end
