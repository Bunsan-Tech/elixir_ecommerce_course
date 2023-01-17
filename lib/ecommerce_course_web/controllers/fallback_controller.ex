defmodule EcommerceCourseWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  alias EcommerceCourseWeb.ChangesetView
  use EcommerceCourseWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(EcommerceCourseWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, schema, %Ecto.Changeset{} = changeset, _}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(EcommerceCourseWeb.ChangesetView)
    |> json(%{
      element: schema,
      message: "This information could not be added",
      errors: ChangesetView.translate_errors(changeset)
    })
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(EcommerceCourseWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, message}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(EcommerceCourseWeb.ErrorView)
    |> json(%{message: message})
  end

  def call(conn, fallback) do
    require IEx
    IEx.pry()

    conn
    |> put_status(:unprocessable_entity)
    |> put_view(EcommerceCourseWeb.ErrorView)
    |> json(%{message: fallback})
  end
end
