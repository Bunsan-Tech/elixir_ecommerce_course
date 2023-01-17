defmodule EcommerceCourse.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  alias EcommerceCourse.Users.User
  alias EcommerceCourse.Carts.Cart
  alias EcommerceCourse.Orders.{ContactInfo, PaymentInfo}

  @required_fields ~w(location contact_info_id user_id cart_id)a
  @optional_fields ~w(delivery_date status price)a

  @foreign_key_type Ecto.UUID
  @primary_key {:id, :binary_id, autogenerate: true}
  schema "orders" do
    field :delivery_date, :utc_datetime_usec
    field :location, :string
    field :price, :float
    field :status, :string

    belongs_to :contact_info, ContactInfo
    belongs_to :user, User
    belongs_to :cart, Cart
    embeds_one(:payment_info, PaymentInfo, on_replace: :update)

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

  def payment_changeset(order, {order_attrs, payment_info}) do
    order
    |> cast(order_attrs, @optional_fields)
    |> put_embed(:payment_info, payment_info)
  end
end
