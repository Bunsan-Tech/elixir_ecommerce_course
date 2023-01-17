defmodule EcommerceCourseWeb.OrderView do
  use EcommerceCourseWeb, :view
  alias EcommerceCourseWeb.OrderView

  def render("index.json", %{orders: orders}) do
    %{data: render_many(orders, OrderView, "order.json")}
  end

  def render("show.json", %{order: order}) do
    %{data: render_one(order, OrderView, "order.json")}
  end

  def render("order.json", %{order: order}) do
    %{
      id: order.id,
      price: order.price,
      status: order.status,
      location: order.location,
      delivery_date: order.delivery_date,
      payment_info: Map.from_struct(order.payment_info)
    }
  end
end
