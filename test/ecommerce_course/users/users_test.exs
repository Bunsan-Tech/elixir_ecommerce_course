defmodule EcommerceCourse.UsersTest do
  use EcommerceCourse.DataCase
  import EcommerceCourse.Factory

  alias EcommerceCourse.Users

  describe "list_users/0" do
    test "return empty list if doesn't have users" do
      assert Users.list_users() == []
    end

    test "return one user in list" do
      user = insert(:user)

      [first_user] = Users.list_users()

      assert user == first_user
    end

    test "return a list of users" do
      insert_list(5, :user)

      users = Users.list_users()

      assert length(users) == 5
    end
  end

  describe "get_user/1" do
    test "user not found" do
      uuid = Faker.UUID.v4()

      assert_raise(Ecto.NoResultsError, fn ->
        Users.get_user!(uuid)
      end)
    end

    @tag :to_implement
    test "user found" do
    end
  end

  describe "get_user_by_username/1" do
    setup do
      user = insert(:user)
      {:ok, user: user}
    end

    test "user not found" do
      username = "invalid_username"

      assert {:error, nil} == Users.get_user_by_username!(username)
    end

    test "found user by username", %{user: user} do
      assert {:ok, user} == Users.get_user_by_username!(user.username)
    end
  end

  describe "create_user/1" do
    test "create user with invalid params" do
      {:error, changeset} = Users.create_user(%{username: "user"})

      refute changeset.valid?
    end

    test "create user with valid params" do
      user = %{
        username: "fake_username",
        password: "123",
        email: Faker.Internet.email()
      }

      {:ok, user} = Users.create_user(user)

      assert user.username == "fake_username"
    end
  end
end
