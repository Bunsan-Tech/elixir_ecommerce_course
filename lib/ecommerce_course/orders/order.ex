defmodule EcommerceCourse.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(location)a
  @optional_fields ~w(delivery_date status price)a

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "orders" do
    field :delivery_date, :utc_datetime_usec
    field :location, :string
    field :price, :float
    field :status, :string

    timestamps()
  end

  @doc false
  def create_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  def update_changeset(order, attrs) do
    order
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
