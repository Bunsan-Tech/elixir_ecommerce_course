defmodule EcommerceCourseWeb.ItemController do
  use EcommerceCourseWeb, :controller

  alias EcommerceCourse.Items
  alias EcommerceCourse.Items.Item

  action_fallback EcommerceCourseWeb.FallbackController

  def index(conn, _params) do
    start = System.monotonic_time()
    items = Items.available_items()
    :telemetry.execute([:phoenix, :request], %{duration: System.monotonic_time() - start}, conn)
    :telemetry.execute([:http, :request, :stop], %{duration: System.monotonic_time() - start})

    render(conn, "index.json", items: items)
  end

  def create(conn, %{"item" => item_params}) do
    with {:ok, %Item{} = item} <- Items.create_item(item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.item_path(conn, :show, item))
      |> render("show.json", item: item)
    end
  end

  def show(conn, %{"id" => id}) do
    item = Items.get_item!(id)
    render(conn, "show.json", item: item)
  end

  def show_by_stream(conn, _params) do
    items = Items.get_items_by_stream()
    render(conn, "streams.json", items: items)
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Items.get_item!(id)

    with {:ok, %Item{} = item} <- Items.update_item(item, item_params) do
      render(conn, "show.json", item: item)
    end
  end

  def delete(conn, %{"id" => id}) do
    item = Items.get_item!(id)

    with {:ok, %Item{}} <- Items.delete_item(item) do
      send_resp(conn, :no_content, "")
    end
  end
end
