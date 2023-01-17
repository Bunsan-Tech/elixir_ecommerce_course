defmodule EcommerceCourseWeb.ContactInfoView do
  use EcommerceCourseWeb, :view
  alias EcommerceCourseWeb.ContactInfoView

  def render("index.json", %{contact_info: contact_info}) do
    %{data: render_many(contact_info, ContactInfoView, "contact_info.json")}
  end

  def render("show.json", %{contact_info: contact_info}) do
    %{data: render_one(contact_info, ContactInfoView, "contact_info.json")}
  end

  def render("contact_info.json", %{contact_info: contact_info}) do
    %{
      id: contact_info.id,
      email: contact_info.email,
      phone: contact_info.phone
    }
  end
end
