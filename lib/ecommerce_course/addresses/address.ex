defmodule EcommerceCourse.Addresses.Address do
  use Ecto.Schema
  import Ecto.Changeset

  alias EcommerceCourse.Users.User

  @required_fields ~w(country_code postal_code street neighborhood user_id)a
  @optional_fields ~w(reference)a

  @foreign_key_type Ecto.UUID
  @primary_key {:id, :binary_id, autogenerate: true}
  schema "addresses" do
    field :country_code, :string
    field :neighborhood, :string
    field :postal_code, :string
    field :reference, :string
    field :street, :string

    belongs_to :user, User

    timestamps()
  end

  def create_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
  end

  def update_changeset(address, attrs) do
    address
    |> cast(attrs, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
  end
end
