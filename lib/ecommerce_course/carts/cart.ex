defmodule EcommerceCourse.Carts.Cart do
  use Ecto.Schema
  import Ecto.Changeset

  alias EcommerceCourse.Users.User
  alias EcommerceCourse.Orders.Order
  alias EcommerceCourse.Carts.CartItem

  @foreign_key_type Ecto.UUID
  @primary_key {:id, :binary_id, autogenerate: true}
  schema "carts" do
    belongs_to :user, User
    has_many :items, CartItem
    has_one :order, Order

    timestamps()
  end

  def create_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, [:user_id])
  end
end
