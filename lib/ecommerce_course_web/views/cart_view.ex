defmodule EcommerceCourseWeb.CartView do
  use EcommerceCourseWeb, :view
  alias EcommerceCourseWeb.CartView

  def render("index.json", %{carts: carts}) do
    %{data: render_many(carts, CartView, "cart.json")}
  end

  def render("show.json", %{cart: cart}) do
    %{data: render_one(cart, CartView, "cart.json")}
  end

  def render("cart.json", %{cart: %{id: id}}) do
    %{
      id: id
    }
  end
end
