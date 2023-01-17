defmodule EcommerceCourseWeb.OrderController do
  use EcommerceCourseWeb, :controller

  alias EcommerceCourse.Orders
  alias EcommerceCourse.Orders.Order

  action_fallback EcommerceCourseWeb.FallbackController

  def index(conn, _params) do
    orders = Orders.list_orders()
    render(conn, "index.json", orders: orders)
  end

  def create(conn, %{"order" => order_params, "payment_info" => payment_info_params}) do
    user = conn.private.guardian_default_resource
    order_params = Map.put(order_params, "user_id", user.id)

    with {:ok, %Order{} = order} <- Orders.create_order(order_params, payment_info_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.order_path(conn, :show, order))
      |> render("show.json", order: order)
    end
  end

  def show(conn, %{"id" => id}) do
    order = Orders.get_order!(id)
    render(conn, "show.json", order: order)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Orders.get_order!(id)

    with {:ok, %Order{} = order} <- Orders.update_order(order, order_params) do
      render(conn, "show.json", order: order)
    end
  end

  def delete(conn, %{"id" => id}) do
    order = Orders.get_order!(id)

    with {:ok, %Order{}} <- Orders.delete_order(order) do
      send_resp(conn, :no_content, "")
    end
  end
end
