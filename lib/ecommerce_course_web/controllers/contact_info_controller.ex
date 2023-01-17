defmodule EcommerceCourseWeb.ContactInfoController do
  use EcommerceCourseWeb, :controller

  alias EcommerceCourse.Orders
  alias EcommerceCourse.Orders.ContactInfo

  action_fallback EcommerceCourseWeb.FallbackController

  def create(conn, %{"contact_info" => contact_info_params}) do
    user = conn.private.guardian_default_resource

    with {:ok, %{contact_info: contact_info}} <-
           Orders.create_contact_info(contact_info_params, user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.contact_info_path(conn, :show, contact_info))
      |> render("show.json", contact_info: contact_info)
    end
  end

  def show(conn, %{"id" => id}) do
    contact_info = Orders.get_contact_info!(id)
    render(conn, "show.json", contact_info: contact_info)
  end

  def update(conn, %{"id" => id, "contact_info" => contact_info_params}) do
    contact_info = Orders.get_contact_info!(id)

    with {:ok, %ContactInfo{} = contact_info} <-
           Orders.update_contact_info(contact_info, contact_info_params) do
      render(conn, "show.json", contact_info: contact_info)
    end
  end

  def delete(conn, %{"id" => id}) do
    contact_info = Orders.get_contact_info!(id)

    with {:ok, %ContactInfo{}} <- Orders.delete_contact_info(contact_info) do
      send_resp(conn, :no_content, "")
    end
  end
end
