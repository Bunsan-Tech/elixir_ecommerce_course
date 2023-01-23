defmodule EcommerceCourse.Metrics do
  use Boundary, top_level?: true, deps: [], exports: [Telemetry]

  alias EcommerceCourse.Metrics.Telemetry

  defmacro __using__(_opts) do
  end

  defmacro count do
    quote do
      function = __ENV__.function |> elem(0)

      Telemetry.emit_metric(function, %{count: 1})
    end
  end
end
