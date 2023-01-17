defmodule EcommerceCourse.Utils do
  @moduledoc """
  Utils for EcommerceCourse project
  """

  def transform_string_map(map) do
    Enum.reduce(map, %{}, fn {key, value}, acc ->
      Map.put(acc, String.to_atom(key), transfom_value(value))
    end)
  end

  defp transfom_value(value) when is_map(value) do
    transform_string_map(value)
  end

  defp transfom_value(value), do: value
end
