defmodule EcommerceCourse.Orders.PaymentInfo do
  use Ecto.Schema

  import Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :payment_method, Ecto.Enum,
      values: [:credit_card],
      default: :credit_card

    field :last_four, :string
    field :amount, :float
    field :email, :string
  end

  @required_fields ~w(payment_method)a
  @optional_fields ~w(last_four unique_number_identifier payment_type email)a

  def changeset(payment_info \\ %__MODULE__{}, attrs) do
    payment_info
    |> cast(attrs, @required_fields ++ @optional_fields)
  end
end
