defprotocol EcommerceCourse.ToMap do
  @fallback_to_any true
  def to_map(value)
end

defmodule EcommerceCourse.Protocols.ToMap do
  @moduledoc """
  Transform data to map
  """
  defimpl EcommerceCourse.ToMap, for: [Map, Any] do
    alias EcommerceCourse.ToMap
    alias EcommerceCourse.ToAtom

    def to_map(value) when is_struct(value), do: value

    def to_map(map) when is_map(map) do
      Enum.reduce(map, %{}, fn {key, value}, acc ->
        Map.put(acc, ToAtom.to_atom(key), ToMap.to_map(value))
      end)
    end

    def to_map(value), do: value
  end
end
