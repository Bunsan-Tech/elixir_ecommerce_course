defmodule EcommerceCourse.Factory.UserFactory do
  alias EcommerceCourse.Users.User

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        date = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

        %User{
          last_logged_in: date,
          email: Faker.Internet.email(),
          password: Faker.String.base64(),
          username: Faker.Internet.user_name()
        }
      end
    end
  end
end
