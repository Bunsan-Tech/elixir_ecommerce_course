defmodule EcommerceCourse.OrdersTest do
  use EcommerceCourse.DataCase
  import EcommerceCourse.Factory
  import Mock
  use Mimic

  alias EcommerceCourse.{Checkout, Orders}

  describe "create_order/2" do
    test "with valid params" do
      with_mock(Checkout,
        submit_order: fn _order, _payment_info -> {:ok, %{status: "confirmed"}} end
      ) do
        contact_info = insert(:contact_info)
        user = insert(:user)
        cart = insert(:cart)

        order =
          Orders.create_order(
            %{
              "location" => Faker.Address.street_name(),
              "contact_info_id" => contact_info.id,
              "user_id" => user.id,
              "cart_id" => cart.id
            },
            %{}
          )

        assert {:ok, %{status: "confirmed"}} == order
      end
    end

    test "with missing params for order creation" do
      contact_info = insert(:contact_info)
      cart = insert(:cart)

      assert_raise(Ecto.InvalidChangesetError, fn ->
        Orders.create_order(
          %{
            "location" => Faker.Address.street_name(),
            "contact_info_id" => contact_info.id,
            "cart_id" => cart.id
          },
          %{}
        )
      end)
    end

    test "with problem on checkout by mock" do
      with_mock(Checkout,
        submit_order: fn _order, _payment_info -> {:error, %{status: "Phone number required"}} end
      ) do
        contact_info = insert(:contact_info)
        user = insert(:user)
        cart = insert(:cart)

        order =
          Orders.create_order(
            %{
              "location" => Faker.Address.street_name(),
              "contact_info_id" => contact_info.id,
              "user_id" => user.id,
              "cart_id" => cart.id
            },
            %{}
          )

        assert {:error, %{status: "Phone number required"}} == order
      end
    end
  end
end
