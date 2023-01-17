defmodule EcommerceCourse.Orders do
  @moduledoc """
  The Orders context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Multi
  alias EcommerceCourse.Repo

  alias EcommerceCourse.Utils
  alias EcommerceCourse.Orders.{ContactInfo, Order}
  alias EcommerceCourse.Checkout
  alias EcommerceCourse.Addresses.Address

  @doc """
  Returns the list of orders.

  ## Examples

      iex> list_orders()
      [%Order{}, ...]

  """
  def list_orders do
    Repo.all(Order)
  end

  @doc """
  Gets a single order.

  Raises `Ecto.NoResultsError` if the Order does not exist.

  ## Examples

      iex> get_order!(123)
      %Order{}

      iex> get_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order!(id), do: Repo.get!(Order, id)

  @doc """
  Creates a order.

  ## Examples

      iex> create_order(%{field: value})
      {:ok, %Order{}}

      iex> create_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order(attrs \\ %{}, payment_info_params) do
    payment_info = Utils.transform_string_map(payment_info_params)
    attrs = Utils.transform_string_map(attrs)

    attrs
    |> Order.create_changeset()
    |> Repo.insert!()
    |> Repo.preload([:user, :contact_info, [cart: :items]])
    |> Checkout.submit_order(payment_info)
  end

  @doc """
  Updates a order.

  ## Examples

      iex> update_order(order, %{field: new_value})
      {:ok, %Order{}}

      iex> update_order(order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order(%Order{} = order, attrs) do
    order
    |> Order.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order.

  ## Examples

      iex> delete_order(order)
      {:ok, %Order{}}

      iex> delete_order(order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order(%Order{} = order) do
    Repo.delete(order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order changes.

  ## Examples

      iex> change_order(order)
      %Ecto.Changeset{data: %Order{}}

  """
  def change_order(attrs \\ %{}) do
    Order.create_changeset(attrs)
  end

  @doc """
  Gets a single contact_info.

  Raises `Ecto.NoResultsError` if the Contact info does not exist.

  ## Examples

      iex> get_contact_info!(123)
      %ContactInfo{}

      iex> get_contact_info!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contact_info!(id), do: Repo.get!(ContactInfo, id)

  @doc """
  Creates a contact_info.

  ## Examples

      iex> create_contact_info(%{field: value})
      {:ok, %ContactInfo{}}

      iex> create_contact_info(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contact_info(attrs \\ %{}, user) do
    attrs = Utils.transform_string_map(attrs)
    address = Map.put(attrs.address, :user_id, user.id)

    Multi.new()
    |> Multi.insert(:address, Address.create_changeset(address))
    |> Multi.insert(:contact_info, fn %{address: address} ->
      contact_info = contact_info_structure(attrs, address)

      ContactInfo.create_changeset(contact_info)
    end)
    |> Repo.transaction()
  end

  defp contact_info_structure(%{phone: phone, email: email}, %{id: address_id}) do
    %{
      phone: phone,
      email: email,
      address_id: address_id
    }
  end

  @doc """
  Updates a contact_info.

  ## Examples

      iex> update_contact_info(contact_info, %{field: new_value})
      {:ok, %ContactInfo{}}

      iex> update_contact_info(contact_info, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_contact_info(%ContactInfo{} = contact_info, attrs) do
    contact_info
    |> ContactInfo.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a contact_info.

  ## Examples

      iex> delete_contact_info(contact_info)
      {:ok, %ContactInfo{}}

      iex> delete_contact_info(contact_info)
      {:error, %Ecto.Changeset{}}

  """
  def delete_contact_info(%ContactInfo{} = contact_info) do
    Repo.delete(contact_info)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contact_info changes.

  ## Examples

      iex> change_contact_info(contact_info)
      %Ecto.Changeset{data: %ContactInfo{}}

  """
  def change_contact_info(attrs \\ %{}) do
    ContactInfo.create_changeset(attrs)
  end
end
