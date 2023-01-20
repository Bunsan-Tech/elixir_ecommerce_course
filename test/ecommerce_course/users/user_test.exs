defmodule EcommerceCourse.UserTest do
  use EcommerceCourse.DataCase

  alias EcommerceCourse.Users.User

  describe "creteate_changeset/1" do
    test "fails if not given required fields" do
      %Ecto.Changeset{} = changeset = User.create_changeset(%{email: Faker.Internet.email()})

      [:username, :password]
      |> Enum.each(fn key ->
        error = {key, {"can't be blank", [validation: :required]}}
        assert error in changeset.errors
      end)

      refute changeset.valid?
    end

    test "return valid changeset with valid params" do
      params = %{
        email: Faker.Internet.email(),
        username: Faker.Internet.user_name(),
        password: Faker.String.base64()
      }

      %Ecto.Changeset{} = changeset = User.create_changeset(params)

      assert changeset.valid?
    end
  end
end
