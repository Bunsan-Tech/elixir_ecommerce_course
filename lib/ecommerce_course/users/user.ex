defmodule EcommerceCourse.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @creation_fields ~w(username password email)a

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "users" do
    field :email, :string
    field :last_logged_in, :utc_datetime_usec
    field :password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def create_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @creation_fields)
    |> validate_required(@creation_fields)
  end

  def update_changeset(user, attrs) do
    user
    |> cast(attrs, @creation_fields ++ [:last_logged_in])
    |> validate_required(@creation_fields ++ [:last_logged_in])
  end
end
