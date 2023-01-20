defmodule EcommerceCourse.CheckoutTest do
  use EcommerceCourse.DataCase
  import EcommerceCourse.Factory

  alias EcommerceCourse.Checkout
  alias EcommerceCourse.Orders.Order

  describe "submit_order/2" do
    test "submit order with cart without items" do
      order = build(:order, cart: build(:cart, items: []))

      assert {:error, "Empty cart"} == Checkout.submit_order(order, %{})
    end

    test "phone number required" do
      order = build(:order, contact_info: build(:contact_info, phone: nil))

      assert {:error, "Phone number required for checkout"} = Checkout.submit_order(order, %{})
    end

    test "submit order with one item" do
      order =
        insert(
          :order,
          cart: build(:cart),
          contact_info: build(:contact_info),
          user: insert(:user)
        )

      payment_info = %{
        payment_method: "credit_card",
        card_number: "1111222233334444"
      }

      {:ok, %Order{} = order} = Checkout.submit_order(order, payment_info)

      assert order.status == "confirmed"
    end
  end
end
