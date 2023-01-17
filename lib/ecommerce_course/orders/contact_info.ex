defmodule EcommerceCourse.Orders.ContactInfo do
  use Ecto.Schema
  import Ecto.Changeset

  @fields ~w(email phone)a
  @email_address_regex ~r/^([a-zA-Z0-9_\-\.\+]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "contact_info" do
    field :email, :string
    field :phone, :string

    timestamps()
  end

  def create_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_format(:email, @email_address_regex)
    |> validate_required(@fields)
  end

  def update_changeset(contact_info, attrs) do
    contact_info
    |> cast(attrs, @fields)
    |> validate_format(:email, @email_address_regex)
    |> validate_required(@fields)
  end
end
