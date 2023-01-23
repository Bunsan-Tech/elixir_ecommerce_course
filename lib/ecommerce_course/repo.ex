defmodule EcommerceCourse.Repo do
  use Boundary, top_level?: true, deps: [Ecto]

  use Ecto.Repo,
    otp_app: :ecommerce_course,
    adapter: Ecto.Adapters.Postgres
end
