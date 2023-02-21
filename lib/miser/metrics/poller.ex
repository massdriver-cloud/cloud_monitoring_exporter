defmodule Miser.Metrics.Poller do
  use PromEx.Plugin

  @default_poll_rate 60_000
  @memory_event [:prom_ex, :plugin, :beam, :memory]

  @impl true
  def polling_metrics(opts) do
    [
      cloud_monitoring_metrics(opts)
    ]
  end

  defp cloud_monitoring_metrics(opts) do
    {poll_rate, opts} = Keyword.pop(opts, :poll_rate, @default_poll_rate)

    Polling.build(
      :cloud_monitoring_metrics,
      poll_rate,
      {__MODULE__, :execute_cloud_monitoring_metrics, [opts]},
      [
        last_value(
          [:beam, :memory, :total, :kilobytes],
          event_name: @memory_event,
          description: "The total amount of memory currently allocated.",
          measurement: :total,
          unit: {:byte, :kilobyte}
        )

        # More memory metrics here
      ]
    )
  end

  @doc false
  def execute_cloud_monitoring_metrics(_opts) do
    memory_measurements =
      :erlang.memory()
      |> Map.new()

    :telemetry.execute(@memory_event, memory_measurements, %{})
  end
end
