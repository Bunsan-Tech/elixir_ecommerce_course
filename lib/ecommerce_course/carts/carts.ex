defmodule EcommerceCourse.Carts do
  @moduledoc """
  The Carts context.
  """

  import Ecto.Query, warn: false
  alias EcommerceCourse.Repo

  alias EcommerceCourse.Items
  alias EcommerceCourse.Items.Item
  alias EcommerceCourse.Utils
  alias EcommerceCourse.Repo

  alias EcommerceCourse.Carts.Cart
  alias EcommerceCourse.Carts.{Cart, CartItem}

  @doc """
  Returns the list of carts.

  ## Examples

      iex> list_carts()
      [%Cart{}, ...]

  """
  def list_carts do
    Repo.all(Cart)
  end

  @doc """
  Gets a single cart.

  Raises `Ecto.NoResultsError` if the Cart does not exist.

  ## Examples

      iex> get_cart!(123)
      %Cart{}

      iex> get_cart!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cart!(id), do: Repo.get!(Cart, id)

  @doc """
  Creates a cart.

  ## Examples

      iex> create_cart(%{field: value})
      {:ok, %Cart{}}

      iex> create_cart(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cart(attrs \\ %{}) do
    attrs
    |> Cart.create_changeset()
    |> Repo.insert()
  end

  @doc """
  Deletes a cart.

  ## Examples

      iex> delete_cart(cart)
      {:ok, %Cart{}}

      iex> delete_cart(cart)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cart(%Cart{} = cart) do
    Repo.delete(cart)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cart changes.

  ## Examples

      iex> change_cart(cart)
      %Ecto.Changeset{data: %Cart{}}

  """
  def change_cart(attrs \\ %{}) do
    Cart.create_changeset(attrs)
  end

  def preload_cart(cart) do
    Repo.preload(cart, [:user, :items])
  end

  @doc """
  Create cart items and adding to cart

  iex> add_cart_items(item_id, quantity)
  """
  def add_cart_items(attrs) do
    attrs = Utils.transform_string_map(attrs)

    with {:ok, _message} <- cart_has_order(attrs.cart_id),
         {:ok, %Item{} = item} <- Items.get_one_item(attrs.item_id) do
      attrs = Map.put(attrs, :item, item)

      attrs
      |> validate_cart_item()
      |> case do
        nil ->
          create_cart_item(attrs)

        cart ->
          update_cart_item(cart, attrs)
      end
    end
  end

  defp cart_has_order(cart_id) do
    Cart
    |> where([c], c.id == ^cart_id)
    |> preload([:order])
    |> Repo.one()
    |> has_order()
  end

  defp has_order(%{order: nil}), do: {:ok, "Cart doesn't have order"}
  defp has_order(_order), do: {:error, "Cart has order"}

  defp create_cart_item(%{quantity: quantity}) when quantity <= 0 do
    {:error, "Item was not added"}
  end

  defp create_cart_item(attrs) do
    attrs
    |> get_price_from_cart_items(nil)
    |> CartItem.create_changeset()
    |> Repo.insert()
  end

  def update_cart_item(cart, attrs) do
    case cart_item_quantity(cart.quantity, attrs.quantity) do
      0 ->
        _ = Repo.delete(cart)
        {:ok, "Item was deleted"}

      quantity ->
        cart
        |> Repo.preload([:item])
        |> get_price_from_cart_items(quantity)
        |> CartItem.update_changeset(%{quantity: quantity})
        |> Repo.update()
    end
  end

  defp get_price_from_cart_items(%{quantity: qty, item: %{price: price}} = cart_item, nil) do
    Map.put(cart_item, :price, price * qty)
  end

  defp get_price_from_cart_items(%{item: %{price: price}} = cart_item, qty) do
    Map.put(cart_item, :price, price * qty)
  end

  defp cart_item_quantity(cart_quantity, updatable_quantity) do
    quantity = cart_quantity + updatable_quantity

    if quantity <= 0 do
      0
    else
      quantity
    end
  end

  defp validate_cart_item(%{item_id: item_id, cart_id: cart_id}) do
    CartItem
    |> where([ci], ci.item_id == ^item_id)
    |> where([ci], ci.cart_id == ^cart_id)
    |> Repo.one()
  end
end
