defmodule EcommerceCourse.Items do
  @moduledoc """
  The Items context.
  """
  use Boundary,
    top_level?: true,
    deps: [
      Ecto,
      Ecto.UUID,
      Ecto.Query,
      Ecto.Schema,
      Ecto.Changeset,
      EcommerceCourse.Repo
    ],
    exports: [Item]

  import Ecto.Query, warn: false
  alias Ecto.UUID
  alias EcommerceCourse.Repo

  alias EcommerceCourse.Items.Item

  @doc """
  Get a list of items

  Validate the item is exist and available

  ## Examples

  iex> available_items()
    [%Item{}, ...]
  """
  def available_items() do
    Item
    |> where([u], u.quantity > ^0)
    |> Repo.all()
  end

  def get_items_by_stream() do
    {:ok, items} =
      Repo.transaction(fn ->
        Item
        |> Repo.stream()
        |> Stream.map(&format_item/1)
        |> Enum.to_list()
      end)

    items
  end

  defp format_item(item) do
    %{
      name: item.name,
      description: item.description,
      price: item.price,
      sku: item.sku
    }
  end

  @doc """
  Gets a single item.

  Raises `Ecto.NoResultsError` if the Item does not exist.

  ## Examples

      iex> get_item!(123)
      %Item{}

      iex> get_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_item!(id), do: Repo.get!(Item, id)

  def get_one(id) do
    with %Item{} = item <- Repo.one(where(Item, [i], i.id == ^id)) do
      {:ok, item}
    else
      nil -> {:error, "Item not found"}
    end
  end

  def get_one_item(id) do
    case UUID.cast(id) do
      {:ok, id} ->
        get_one(id)

      :error ->
        {:error, "Cannot cast item uuid"}
    end
  end

  @doc """
  Creates a item.

  ## Examples

      iex> create_item(%{field: value})
      {:ok, %Item{}}

      iex> create_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_item(attrs \\ %{}) do
    attrs
    |> Item.create_changeset()
    |> Repo.insert()
  end

  @doc """
  Updates a item.

  ## Examples

      iex> update_item(item, %{field: new_value})
      {:ok, %Item{}}

      iex> update_item(item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_item(%Item{} = item, attrs) do
    item
    |> Item.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a item.

  ## Examples

      iex> delete_item(item)
      {:ok, %Item{}}

      iex> delete_item(item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_item(%Item{} = item) do
    Repo.delete(item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item changes.

  ## Examples

      iex> change_item(item)
      %Ecto.Changeset{data: %Item{}}

  """
  def change_item(attrs \\ %{}) do
    Item.create_changeset(attrs)
  end
end
