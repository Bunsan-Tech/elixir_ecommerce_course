defmodule EcommerceCourseWeb.ItemView do
  use EcommerceCourseWeb, :view
  alias EcommerceCourseWeb.ItemView

  def render("index.json", %{items: items}) do
    %{data: render_many(items, ItemView, "item.json")}
  end

  def render("show.json", %{item: item}) do
    %{data: render_one(item, ItemView, "item.json")}
  end

  def render("item.json", %{item: item}) do
    %{
      id: item.id,
      name: item.name,
      quantity: item.quantity,
      price: item.price,
      description: item.description,
      image: item.image,
      sku: item.sku,
      inventory_updated_add: item.inventory_updated_add
    }
  end
end
