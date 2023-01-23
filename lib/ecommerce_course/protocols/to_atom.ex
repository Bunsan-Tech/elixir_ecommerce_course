defprotocol EcommerceCourse.ToAtom do
  @fallback_to_any true
  def to_atom(value)
end

defmodule EcommerceCourse.Protocols.ToAtom do
  @moduledoc """
  Transform to atom
  """

  defimpl EcommerceCourse.ToAtom, for: [String, Any] do
    def to_atom(value) when is_binary(value) do
      String.to_atom(value)
    end

    def to_atom(value), do: value
  end
end
