defmodule EcommerceCourse.Items.BulkUpload do
  @moduledoc """
  Module for upload a huge quantity of items by CSV file
  """
  alias EcommerceCourse.Repo
  alias EcommerceCourse.Utils
  alias EcommerceCourse.Items.Item

  @extension_file ".csv"

  @doc """
    iex> path = "./priv/resources/items.csv"
  """
  def bulk_upload(file_path \\ "./priv/resources/items.csv") do
    items =
      file_path
      |> exists_file()
      |> check_extension()
      |> File.stream!()
      |> CSV.decode(headers: true)
      |> Stream.map(fn row ->
        parser_row(row)
      end)
      |> Enum.to_list()

    Repo.insert_all(Item, items, conflict_target: [:sku], on_conflict: :replace_all)
  end

  defp exists_file(path) do
    unless File.exists?(path) do
      raise ArgumentError, "file #{path} does not exists"
    end

    path
  end

  defp check_extension(file) do
    unless file |> Path.extname() |> String.downcase() == @extension_file do
      raise ArgumentError, "file #{file} does not have .csv extension"
    end

    file
  end

  defp parser_row({:ok, row}) do
    row
    |> build_item_map()
    |> Utils.transform_string_map()
  end

  defp parser_row({_, _}), do: nil

  defp build_item_map(
         %{
           "price" => price,
           "quantity" => quantity
         } = item
       ) do
    date = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    Map.merge(item, %{
      "id" => Ecto.UUID.generate(),
      "inserted_at" => date,
      "updated_at" => date,
      "price" => transform_price_and_quantity(price, &Float.parse/1),
      "quantity" => transform_price_and_quantity(quantity, &Integer.parse/1)
    })
  end

  defp transform_price_and_quantity(price, func) do
    case func.(price) do
      {number, _} -> number
      _ -> 0
    end
  end
end
