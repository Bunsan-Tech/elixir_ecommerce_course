defmodule EcommerceCourse.Factory.OrderFactory do
  alias EcommerceCourse.Orders.{Order, PaymentInfo}

  defmacro __using__(_opts) do
    quote do
      def order_factory do
        date = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

        %Order{
          status: "created",
          price: Faker.Commerce.price(),
          location: Faker.Address.street_address(),
          delivery_date: date
        }
      end

      def payment_info_factory do
        %PaymentInfo{
          payment_method: :credit_cart,
          last_four: nil,
          amount: nil,
          email: nil
        }
      end
    end
  end
end
