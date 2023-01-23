defmodule EcommerceCourse.Guardian.AuthAccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :ecommerce_course

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
end
