defmodule EcommerceCourse.CartFactory do
  alias EcommerceCourse.Carts.{Cart, CartItem}

  defmacro __using__(_opts) do
    quote do
      def cart_factory do
        date = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

        %Cart{
          items: build_list(2, :cart_item),
          user: build(:user)
        }
      end

      def cart_item_factory do
        %CartItem{
          quantity: Enum.random(1..100),
          price: Faker.Commerce.price(),
          item: build(:item)
        }
      end
    end
  end
end
