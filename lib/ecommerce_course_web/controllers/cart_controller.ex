defmodule EcommerceCourseWeb.CartController do
  use EcommerceCourseWeb, :controller

  alias EcommerceCourse.Carts.CartItem
  alias EcommerceCourse.Carts
  alias EcommerceCourse.Carts.Cart
  alias EcommerceCourseWeb.FallbackController

  action_fallback EcommerceCourseWeb.FallbackController

  def create(conn, _params) do
    user = conn.private.guardian_default_resource

    with {:ok, user_uuid} <- Ecto.UUID.cast(user.id),
         {:ok, %Cart{} = cart} <-
           Carts.create_cart(%{user_id: user_uuid}) do
      cart = Carts.preload_cart(cart)

      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.cart_path(conn, :show, cart))
      |> render("show.json", cart: cart)
    end
  end

  def add_cart_items(conn, params) do
    with {:ok, %CartItem{} = cart_item} <- Carts.add_cart_items(params) do
      conn
      |> put_status(:created)
      |> json(%{
        quantity: cart_item.quantity,
        item_id: cart_item.item_id,
        cart_id: cart_item.cart_id,
        price: inspect(cart_item.price)
      })
    else
      {:ok, message} ->
        conn
        |> put_status(:ok)
        |> json(%{message: message})

      other ->
        FallbackController.call(conn, other)
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
