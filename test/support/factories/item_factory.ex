defmodule EcommerceCourse.Factory.ItemFactory do
  alias EcommerceCourse.Items.Item

  defmacro __using__(_opts) do
    quote do
      def item_factory do
        date = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

        %Item{
          description: Faker.Lorem.word(),
          image: Faker.Avatar.image_url(),
          inventory_updated_add: date,
          name: Faker.Commerce.product_name(),
          price: Faker.Commerce.price(),
          quantity: Enum.random(1_000..10_000),
          sku: Faker.Lorem.word()
        }
      end
    end
  end
end
