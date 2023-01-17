defmodule EcommerceCourseWeb.AddressView do
  use EcommerceCourseWeb, :view
  alias EcommerceCourseWeb.AddressView

  def render("index.json", %{addresses: addresses}) do
    %{data: render_many(addresses, AddressView, "address.json")}
  end

  def render("show.json", %{address: address}) do
    %{data: render_one(address, AddressView, "address.json")}
  end

  def render("address.json", %{address: address}) do
    %{
      id: address.id,
      country_code: address.country_code,
      postal_code: address.postal_code,
      street: address.street,
      neighborhood: address.neighborhood,
      reference: address.reference
    }
  end
end
