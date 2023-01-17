defmodule EcommerceCourseWeb.AuthController do
  use EcommerceCourseWeb, :controller

  alias EcommerceCourse.Guardian
  alias EcommerceCourse.Users

  def login(conn, %{"username" => username, "password" => password}) do
    with {:ok, user} <- Users.get_user_by_username!(username),
         true <- validate_password(user, password) do
      conn = Guardian.Plug.sign_in(conn, user)

      json(conn, %{
        "token" => conn.private.guardian_default_token,
        "username" => username,
        "email" => user.email
      })
    else
      _ ->
        send_resp(conn, 401, "Invalid username or password")
    end
  end

  def logout(conn, _params) do
    conn
    |> Guardian.Plug.sign_out()
    |> send_resp(200, "")
  end

  defp validate_password(user, password) do
    user.password == password
  end
end
