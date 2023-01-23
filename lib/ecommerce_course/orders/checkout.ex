defmodule EcommerceCourse.Checkout do
  @moduledoc """
  Checkout logic
  """

  alias Ecto.Multi
  alias EcommerceCourse.Orders.Order
  alias EcommerceCourse.Items.Item
  alias EcommerceCourse.Repo

  @type payment_map :: %{amount: integer, email: charlist(), last_four: binary()}

  @spec submit_order(%Order{}, map()) :: {:ok, %Order{}} | {:error, String.t()}
  def submit_order(%Order{cart: %{items: []}}, _payment_info) do
    {:error, "Empty cart"}
  end

  def submit_order(order, payment) do
    with :ok <- validate_phone(order),
         {:ok, order} <- verify_order(order, payment) do
      {:ok, order.update_payment_info}
    end
  end

  @spec validate_phone(map()) :: :ok | {:error, String.t()}
  defp validate_phone(%{contact_info: %{phone: phone}}) when is_binary(phone) do
    :ok
  end

  defp validate_phone(_order), do: {:error, "Phone number required for checkout"}

  @spec verify_order(%Order{}, map()) :: {:ok, any()} | {:error, String.t()}
  defp verify_order(order, payment) do
    Multi.new()
    |> Multi.update(:order, Order.update_changeset(order, %{status: "in_process"}))
    |> Multi.merge(fn _something ->
      order
      |> Repo.preload(cart: [items: :item])
      |> apply_inventory_reductions()
    end)
    |> Multi.run(:update_payment_info, fn repo, %{order: order} ->
      order = Repo.preload(order, cart: [items: :item])
      save_payment_info(payment, order) |> repo.update()
    end)
    |> Repo.transaction()
  end

  @spec apply_inventory_reductions(map()) :: {:ok, %Item{}} | {:error, String.t()}
  defp apply_inventory_reductions(%{cart: %{items: []}}) do
    {:error, "Cars does not have items"}
  end

  defp apply_inventory_reductions(%{cart: %{items: items}}) do
    items
    |> Enum.reduce(Multi.new(), fn %{quantity: qty, item: item}, multi ->
      multi
      |> Multi.update(
        "item-#{item.id}",
        Item.update_changeset(item, %{quantity: item.quantity - qty})
      )
    end)
  end

  @type credit_cart :: %{payment_method: charlist(), card_number: charlist(), last_four: binary()}
  @spec save_payment_info(credit_cart, %Order{}) ::
          {:error, String.t() | Ecto.Changeset.t()}
  defp save_payment_info(
         %{payment_method: "credit_card", card_number: card_number} = payment_info,
         order
       ) do
    card_number
    |> String.length()
    |> create_payment_struct(payment_info, order)
    |> set_order_fields()
    |> then(&Order.payment_changeset(order, &1))
  end

  defp save_payment_info(_paymet_info, _order),
    do: {:error, "Credit card required for checkout"}

  @spec create_payment_struct(non_neg_integer(), map(), %Order{}) :: map() | {:error, String.t()}
  defp create_payment_struct(16 = _card_lenght, %{card_number: card_number}, %{
         contact_info: %{email: email},
         cart: %{items: items}
       }) do
    %{
      last_four: String.slice(card_number, 12..15),
      email: email,
      amount: Enum.reduce(items, 0.0, &(&1.price + &2))
    }
  end

  defp create_payment_struct(_card_lenght, _payment_info, _order),
    do: {:error, "Please validate card number"}

  @spec set_order_fields(payment_map) :: {any(), payment_map()}
  defp set_order_fields(payment_attrs) do
    order_fields = %{
      price: payment_attrs.amount,
      status: "confirmed",
      delivery_date: NaiveDateTime.add(NaiveDateTime.utc_now(), 2, :second)
    }

    {order_fields, payment_attrs}
  end
end
