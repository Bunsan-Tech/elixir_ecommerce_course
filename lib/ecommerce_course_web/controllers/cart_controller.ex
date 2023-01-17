defmodule EcommerceCourseWeb.CartController do
  use EcommerceCourseWeb, :controller

  alias EcommerceCourse.Carts
  alias EcommerceCourse.Carts.Cart

  action_fallback EcommerceCourseWeb.FallbackController

  def create(conn, _params) do
    with {:ok, %Cart{} = cart} <- Carts.create_cart(%{}) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.cart_path(conn, :show, cart))
      |> render("show.json", cart: cart)
    end
  end

  def show(conn, %{"id" => id}) do
    cart = Carts.get_cart!(id)
    render(conn, "show.json", cart: cart)
  end

  def delete(conn, %{"id" => id}) do
    cart = Carts.get_cart!(id)

    with {:ok, %Cart{}} <- Carts.delete_cart(cart) do
      send_resp(conn, :no_content, "")
    end
  end
end
