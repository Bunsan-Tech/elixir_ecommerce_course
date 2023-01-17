defmodule EcommerceCourse.Metrics.Telemetry do
  @moduledoc """
  Metrics Telemetry.Call telemetry.
  """
  require Logger

  def emit_metric(function, metrics \\ %{}) do
    :telemetry.execute([:ecommerce_course] ++ [:orders, function], metrics)
  end
end
